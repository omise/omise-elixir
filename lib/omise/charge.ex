defmodule Omise.Charge do
  @moduledoc ~S"""
  Provides Charge API interfaces.

  <https://www.omise.co/charges-api>
  """

  use Omise.HTTPClient, endpoint: "charges"

  @doc ~S"""
  List all charges.

  Returns `{:ok, charges}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Charge.list

      Omise.Charge.list(limit: 10)

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list(params \\ [], options \\ []) do
    get(@endpoint, params, options)
  end

  @doc ~S"""
  Retrieve a charge.

  ## Examples

      Omise.Charge.retrieve("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(id, options \\ []) do
    get("#{@endpoint}/#{id}", [], options)
  end

  @doc ~S"""
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
      Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        card: "tokn_test_51w6fvilnsxalda4cih"
      )

      # Charge a card using a customer.
      Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        customer: "cust_test_51vtchzn51al0jaa92q"
      )

      # Charge a card using a customer and a card.
      Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        customer: "cust_test_51vtchzn51al0jaa92q",
        card: "card_test_51w6jblhhpzmc2g8bcm"
      )

  """
  @spec create(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def create(params, options \\ []) do
    post(@endpoint, params, options)
  end

  @doc ~S"""
  Update a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `description` - (optional) A custom description for the charge. This value can be searched for in your dashboard.

  ## Examples

      Omise.Charge.update("chrg_test_4xso2s8ivdej29pqnhz",
        description: "The funny thing is that when I am okay, oh it makes me wish for rain")

  """
  @spec update(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def update(id, params, options \\ []) do
    put("#{@endpoint}/#{id}", params, options)
  end

  @doc ~S"""
  Capture a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ***NOTE***:
  If you have created a charge and passed `capture=false` you'll have an authorized only charge that you can capture at a later time.
  You can hold it for as long as permitted by the issuing bank. This delay may vary between cards from 1 to 30 days.

  ## Examples

      Omise.Charge.capture("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec capture(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def capture(id, options \\ []) do
    post("#{@endpoint}/#{id}/capture", [], options)
  end

  @doc ~S"""
  Reverse an uncaptured charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ***NOTE***:
  If you have created a charge and passed `capture=false`,
  you'll have an authorized only charge that can be reversed, release hold money, at a later time.

  ## Examples

      Omise.Charge.reverse("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec reverse(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def reverse(id, options \\ []) do
    post("#{@endpoint}/#{id}/reverse", [], options)
  end

  @doc ~S"""
  Search all the charges.

  Returns `{:ok, charges}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:

      <https://www.omise.co/search-query-and-filters>

  ## Examples

      Omise.Charge.search(filters: [paid: true])

      Omise.Charge.search(query: "omise")

  """
  @spec search(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def search(params \\ [], options \\ []) do
    Omise.Search.execute("charge", params, options)
  end

  @doc ~S"""
  Create a refund.

  Returns `{:ok, refund}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `amount` - The amount in the smallest subunits of the currency used.
      So for thb (Thai Baht) you'll need to pass the amount in satangs.

  ## Examples

      Omise.Charge.refund("chrg_test_520jim7x8u6t4si58va", amount: 100_00)

  """
  @spec refund(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def refund(id, params, options \\ []) do
    post("#{@endpoint}/#{id}/refunds", params, options)
  end

  @doc ~S"""
  List all refunds.

  Returns `{:ok, refunds}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Charge.list_refunds("chrg_test_52oo08bwpgnwb95rye8")

  """
  @spec list_refunds(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list_refunds(id, params \\ [], options \\ []) do
    get("#{@endpoint}/#{id}/refunds", params, options)
  end

  @doc ~S"""
  Retrieve a refund.

  Returns `{:ok, refund}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Charge.retrieve_refund("chrg_test_520jim7x8u6t4si58va", "rfnd_test_4zgf1d7jcw5kr123puq")

  """
  @spec retrieve_refund(String.t, String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve_refund(id, refund_id, options \\ []) do
    get("#{@endpoint}/#{id}/refunds/#{refund_id}", [], options)
  end

  @doc ~S"""
  List all charge schedules.

  Returns `{:ok, schedules}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Charge.list_schedules

  """
  @spec list_schedules(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list_schedules(params \\ [], options \\ []) do
    get("#{@endpoint}/schedules", params, options)
  end
end
