defmodule Omise.Utils do
  @moduledoc false

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
