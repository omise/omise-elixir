defmodule Omise.Charges do
  @moduledoc """
  Provides Charges API interfaces.

  https://www.omise.co/charges-api
  """

  @endpoint "charges"

  @doc """
  List all charges.

  Returns `{:ok, charges}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      {:ok, charges} = Omise.Charges.list

  """
  @spec list(Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def list(params \\ []) do
    Omise.make_request(:get, @endpoint, [params: params])
  end

  @doc """
  Retrieve a charge.

  ## Examples

      {:ok, charge} = Omise.Charges.retrieve("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec retrieve(String.t) :: {:ok, Map.t} | {:error, Map.t}
  def retrieve(id) do
    Omise.make_request(:get, "#{@endpoint}/#{id}")
  end

  @doc """
  Create a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `customer` - (required or optional) A valid `CUSTOMER_ID` that has at least one card already associated.
      By default the default card of the customer will be used.
      This parameter is required unless passing a `TOKEN_ID` in the card parameter.
    * `card` - (required or optional) A valid unused `TOKEN_ID` or `CARD_ID`.
      In the case of the `CARD_ID` the customer parameter must be present and be the owner of the card.
      For the `TOKEN_ID`, the customer must not be passed.
    * `amount` - (required, minimum: 2000, maximum: 100000000) The amount in the smallest subunits of the currency used.
      For thb (Thai Baht) you'll need to pass the amount in satangs.
    * `currency` - (required) The currency in which you want the charge to be done. The default and only valid value is thb.
    * `description` - (optional) A custom description for the charge. This value can be searched for in your dashboard.
    * `capture` - (optional) Whether or not you want the charge to be captured right away, when not specified it is set to true.
    * `return_uri` - (optional) The url where we will return the customer after the charge has been authorized with 3-D Secure.

  ## Examples

      # Charge a card using a token.
      {:ok, charge} = Omise.Charges.create(
        amount: 10000,
        currency: "thb",
        card: "tokn_test_51w6fvilnsxalda4cih"
      )

      # Charge a card using a customer.
      {:ok, charge} = Omise.Charges.create(
        amount: 10000,
        currency: "thb",
        customer: "cust_test_51vtchzn51al0jaa92q"
      )

      # Charge a card using a customer and a card.
      {:ok, charge} = Omise.Charges.create(
        amount: 10000,
        currency: "thb",
        customer: "cust_test_51vtchzn51al0jaa92q",
        card: "card_test_51w6jblhhpzmc2g8bcm"
      )

  """
  @spec create(Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def create(params) do
    Omise.make_request(:post, @endpoint, [], {:form, params})
  end

  @doc """
  Update a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `description` - (optional) A custom description for the charge. This value can be searched for in your dashboard.

  ## Examples

      {:ok, charge} =
        Omise.Charges.update("chrg_test_4xso2s8ivdej29pqnhz", description: "Hello from the outside.")

  """
  @spec update(String.t, Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def update(id, params) do
    Omise.make_request(:patch, "#{@endpoint}/#{id}", [], {:form, params})
  end

  @doc """
  Capture a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ***NOTE***:
  If you have created a charge and passed `capture=false` you'll have an authorized only charge that you can capture at a later time.
  You can hold it for as long as permitted by the issuing bank. This delay may vary between cards from 1 to 30 days.

  ## Examples

      {:ok, charge} = Omise.Charges.capture("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec capture(String.t) :: {:ok, Map.t} | {:error, Map.t}
  def capture(id) do
    Omise.make_request(:post, "#{@endpoint}/#{id}/capture")
  end
end
