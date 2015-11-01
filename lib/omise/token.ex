defmodule Omise.Token do
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

    {:ok, token} = Omise.Token.create(params)
    token_id = token["id"]
  ```

  """
  def create(params) do
    Omise.post(@endpoint, params)
  end
end
