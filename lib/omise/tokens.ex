defmodule Omise.Tokens do
  @moduledoc """
  An API for working with Token at Omise.
  """

  @endpoint "tokens"

  @doc """
  Create a token.

  ## Example

  ```
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
  ```

  """
  def create(params) do
    Omise.make_request({:post, @endpoint, Omise.Util.normalize_card_params(params)})
  end
end
