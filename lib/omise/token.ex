defmodule Omise.Token do
  @moduledoc """
  An API for working with Token at Omise.
  """

  @url "https://vault.omise.co/tokens"

  @doc """
  Create a token.

  ## Example

  ```
    params = %{
      name: "JOHN DOE",
      city: "Bangkok",
      postal_code: 10320,
      number: 4242424242424242,
      security_code: 123,
      expiration_month: 10,
      expiration_year: 2019
    }

    {:ok, token} = Omise.Token.create
  ```

  """
  def create(params) do
    @url
      |> HTTPoison.post({:form, Omise.Util.transform_token_params(params)}, Omise.req_headers, Omise.vault_auth)
      |> Omise.Util.handle_response
  end
end
