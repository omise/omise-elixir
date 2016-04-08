defmodule Omise.Tokens do
  @moduledoc """
  Provides Tokens API interfaces.

  https://www.omise.co/tokens-api

  ***NOTE***:
  Full Credit Card data should never go through your server.
  Do not send the credit card data to Omise from your servers directly.
  You must send the card data from the client browser via Javascript (Omise-JS).
  The methods described on this page should only be used either with fake data in test mode (e.g.: quickly creating some fake data, testing our API from a terminal, etc.), or if you are PCI-DSS compliant.
  Sending card data from server requires a valid PCI-DSS certification. You can learn more about this in [Security Best Practices](https://www.omise.co/security-best-practices)
  """

  @endpoint "tokens"

  @doc """
  Create a token.

  Returns `{:ok, token}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `name` - The cardholder name as printed on the card.
    * `number` - The card number. Note that the number you pass can contains spaces and dashes but will be stripped from the response.
    * `expiration_month` - The expiration month printed on the card in the format M or MM.
    * `expiration_year` - The expiration year printed on the card in the format YYYY.
    * `security_code` - The security code (CVV, CVC, etc) printed on the back of the card.
    * `city` - The postal code from the city where the card was issued.
    * `postal_code` - The city where the card was issued.

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
  @spec create(Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def create(params) do
    Omise.make_request(:post, @endpoint, [], {:form, Omise.Util.normalize_card_params(params)})
  end
end
