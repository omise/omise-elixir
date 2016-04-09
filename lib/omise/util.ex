defmodule Omise.Util do
  @moduledoc false

  # Responses

  def handle_response(%HTTPoison.Response{body: body}) do
    body
    |> process_response
    |> normalize_response
  end

  defp process_response(body) do
    Poison.decode!(body, keys: :atoms)
  end

  defp normalize_response(response = %{object: "error"}) do
    {:error, response}
  end
  defp normalize_response(response) do
    {:ok, response}
  end

  # Cards

  def normalize_card_params(params) do
    Enum.map params, fn({k, v}) ->
      {"card[#{k}]", v}
    end
  end

  # Recipients

  def normalize_recipient_params(params) do
    params
    |> Keyword.delete(:bank_account)
    |> Keyword.merge(normalize_bank_account(params[:bank_account]))
  end

  defp normalize_bank_account(nil), do: []
  defp normalize_bank_account(params) do
    Enum.map params, fn({k, v}) ->
      {"bank_account[#{k}]", v}
    end
  end
end
