defmodule Omise.Util do
  @moduledoc false

  def handle_response(%HTTPoison.Response{body: body}) do
    body
    |> process_response
    |> normalize_response
  end

  defp process_response(body) do
    decoded_body = Poison.decode!(body, keys: :atoms)
    case decoded_body do
      %{object: "error"} ->
        Poison.decode!(body, keys: :atoms, as: initialize_module("error"))

      %{object: "list", data: [ %{object: object} | _ ]} ->
        Poison.decode!(body, keys: :atoms, as: %{data: [initialize_module(object)]})

      %{object: object} when object != "list" ->
        Poison.decode!(body, keys: :atoms, as: initialize_module(object))

      _ ->
        decoded_body
    end
  end

  defp normalize_response(error = %Omise.Error{}), do: {:error, error}
  defp normalize_response(event = %Omise.Event{}), do: {:ok, event}
  defp normalize_response(%{data: data}),          do: {:ok, data}
  defp normalize_response(data),                   do: {:ok, data}

  defp initialize_module(object) do
    Omise
    |> Module.concat(String.capitalize(object))
    |> struct
  end

  def normalize_card_params(params) do
    Enum.map(params, fn {k, v} -> {"card[#{k}]", v} end)
  end

  def normalize_recipient_params(params) do
    params
    |> Keyword.delete(:bank_account)
    |> Keyword.merge(normalize_bank_account_params(params[:bank_account]))
  end

  defp normalize_bank_account_params(params) do
    [
      "bank_account[brand]":  params[:brand],
      "bank_account[number]": params[:number],
      "bank_account[name]":   params[:name]
    ]
  end
end
