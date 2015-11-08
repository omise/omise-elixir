defmodule Omise.Util do
  ### Response Handling ###

  @doc false
  def handle_response(%HTTPoison.Response{body: body = %{object: "error"}}) do
    {:error, %{code: body.code, message: body.message}}
  end
  def handle_response(%HTTPoison.Response{body: body}) do
    {:ok, body}
  end

  ### Card Params Normalization ###

  @doc false
  def normalize_card_params(params) do
    Enum.map(params, fn {k, v} -> {"card[#{k}]", v} end)
  end

  ### Recipient Params Normalization ###

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
