defmodule Omise.Util do
  @moduledoc false

  @doc false
  def handle_response(%HTTPoison.Response{body: %Omise.Error{} = error}) do
    {:error, error}
  end
  def handle_response(%HTTPoison.Response{body: %{data: data}}) do
    {:ok, data}
  end
  def handle_response(%HTTPoison.Response{body: body}) do
    {:ok, body}
  end

  @doc false
  def normalize_card_params(params) do
    Enum.map(params, fn {k, v} -> {"card[#{k}]", v} end)
  end

  @doc false
  def normalize_recipient_params(params) do
    params
    |> Dict.delete(:bank_account)
    |> Dict.merge(normalize_bank_account_params(params[:bank_account]))
  end

  defp normalize_bank_account_params(params) do
    [
      "bank_account[brand]":  params[:brand],
      "bank_account[number]": params[:number],
      "bank_account[name]":   params[:name]
    ]
  end
end
