defmodule Omise.Tokens do
  @moduledoc """
  Provides Tokens API interfaces.
  """

  @endpoint "tokens"

  @doc """
  Create a token.

  Returns `{:ok, token}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      params = [
        name: "Edward Elric",
        city: "Bangkok",
        postal_code: 10320,
        number: 4242424242424242,
        security_code: 123,
        expiration_month: 10,
        expiration_year: 2019
      ]

      {:ok, token} = Omise.Tokens.create(params)

  """
  @spec create(Keyword.t) :: {:ok, Omise.Token.t} | {:error, Omise.Error.t}
  def create(params) do
    Omise.make_request(:post, @endpoint, [], {:form, Omise.Util.normalize_card_params(params)})
  end
end
