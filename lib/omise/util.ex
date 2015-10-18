defmodule Omise.Util do
  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.decode!(body)}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 404}}) do
    {:error, "Not found"}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: status_code}}) do
    {:error, status_code}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  def transform_to_keyword(params) when is_map(params) do
    params |> Enum.into(Keyword.new)
  end

  def transform_to_keyword(params) do
    params
  end

  def transform_card_params(params) do
    params |> Enum.map(fn {k, v} -> {"card[#{k}]", v} end)
  end

  def transform_recipient_params(params) do
    params
    |> Map.delete(:bank_account)
    |> Map.merge(normalize_bank_account_params(params[:bank_account]))
  end

  defp normalize_bank_account_params(params) do
    %{
      "bank_account[brand]":  params.brand,
      "bank_account[number]": params.number,
      "bank_account[name]":   params.name
    }
  end
end
