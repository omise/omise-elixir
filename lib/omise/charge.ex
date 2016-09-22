defmodule Omise.Charge do
  @moduledoc """
  Provides Charge API interfaces.

  https://www.omise.co/charges-api
  """

  defstruct [
    object:          "charge",
    id:              nil,
    livemode:        nil,
    location:        nil,
    status:          nil,
    amount:          nil,
    currency:        nil,
    description:     nil,
    capture:         nil,
    authorized:      nil,
    reversed:        nil,

    # Version: 2014-07-27 => captured
    # Version: 2015-11-17 => paid
    captured:        nil,
    paid:            nil,

    transaction:     nil,
    card:            %Omise.Card{},
    refunded:        nil,
    refunds:         %Omise.List{data: [%Omise.Refund{}]},
    failure_code:    nil,
    failure_message: nil,
    customer:        nil,
    ip:              nil,
    dispute:         %Omise.Dispute{},
    created:         nil,
    return_uri:      nil,
    authorize_uri:   nil,

    # Deprecated Attribute
    reference:       nil
  ]

  @type t :: %__MODULE__{
    object:          String.t,
    id:              String.t,
    livemode:        boolean,
    location:        String.t,
    status:          String.t,
    amount:          integer,
    currency:        String.t,
    description:     String.t,
    capture:         boolean,
    authorized:      boolean,
    reversed:        boolean,

    # Version: 2014-07-27 => captured
    # Version: 2015-11-17 => paid
    captured:        boolean,
    paid:            boolean,

    transaction:     String.t,
    card:            Omise.Card.t,
    refunded:        integer,
    refunds:         Omise.List.t,
    failure_code:    String.t,
    failure_message: String.t,
    customer:        String.t,
    ip:              String.t,
    dispute:         Omise.Dispute.t,
    created:         String.t,
    return_uri:      String.t,
    authorize_uri:   String.t,

    # Deprecated Attribute
    reference:       String.t
  }

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

      Omise.Charge.list

      Omise.Charge.list(limit: 10)

  """
  @spec list(Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.HTTP.make_request(:get, @endpoint, params: params, as: %Omise.List{data: [%__MODULE__{}]})
  end

  @doc """
  Retrieve a charge.

  ## Examples

      Omise.Charge.retrieve("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec retrieve(String.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id) do
    Omise.HTTP.make_request(:get, "#{@endpoint}/#{id}", as: %__MODULE__{})
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
  @spec create(Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def create(params) do
    Omise.HTTP.make_request(:post, @endpoint, body: {:form, params}, as: %__MODULE__{})
  end

  @doc """
  Update a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `description` - (optional) A custom description for the charge. This value can be searched for in your dashboard.

  ## Examples

      Omise.Charge.update("chrg_test_4xso2s8ivdej29pqnhz",
        description: "The funny thing is that when I am okay, oh it makes me wish for rain")

  """
  @spec update(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def update(id, params) do
    Omise.HTTP.make_request(:patch, "#{@endpoint}/#{id}", body: {:form, params}, as: %__MODULE__{})
  end

  @doc """
  Capture a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ***NOTE***:
  If you have created a charge and passed `capture=false` you'll have an authorized only charge that you can capture at a later time.
  You can hold it for as long as permitted by the issuing bank. This delay may vary between cards from 1 to 30 days.

  ## Examples

      Omise.Charge.capture("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec capture(String.t) :: {:ok, t} | {:error, Omise.Error.t}
  def capture(id) do
    Omise.HTTP.make_request(:post, "#{@endpoint}/#{id}/capture", as: %__MODULE__{})
  end

  @doc """
  Reverse an uncaptured charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ***NOTE***:
  If you have created a charge and passed `capture=false`,
  you'll have an authorized only charge that can be reversed, release hold money, at a later time.

  ## Examples

      Omise.Charge.reverse("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec reverse(String.t) :: {:ok, t} | {:error, Omise.Error.t}
  def reverse(id) do
    Omise.HTTP.make_request(:post, "#{@endpoint}/#{id}/reverse", as: %__MODULE__{})
  end

  @doc """
  Search all the charges.

  Returns `{:ok, charges}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:

      https://www.omise.co/search-query-and-filters

  ## Examples

      Omise.Charge.search(filters: [paid: true])

      Omise.Charge.search(query: "omise")

  """
  @spec search(Keyword.t) :: {:ok, Omise.Search.t} | {:error, Omise.Error.t}
  def search(params \\ []) do
    Omise.Search.execute("charge", params)
  end
end
