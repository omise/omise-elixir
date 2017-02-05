defmodule Omise.Card do
  @moduledoc ~S"""
  Provides Card API interfaces.

  https://www.omise.co/cards-api
  """

  import Omise.HTTP

  defstruct [
    object:              "card",
    id:                  nil,
    livemode:            nil,
    location:            nil,
    country:             nil,
    city:                nil,
    bank:                nil,
    postal_code:         nil,
    financing:           nil,
    last_digits:         nil,
    brand:               nil,
    expiration_month:    nil,
    expiration_year:     nil,
    fingerprint:         nil,
    name:                nil,
    security_code_check: nil,
    created:             nil,
    deleted:             false
  ]

  @type t :: %__MODULE__{
    object:              String.t,
    id:                  String.t,
    livemode:            boolean,
    location:            String.t,
    country:             String.t,
    city:                String.t,
    bank:                String.t,
    postal_code:         String.t,
    financing:           String.t,
    last_digits:         String.t,
    brand:               String.t,
    expiration_month:    integer,
    expiration_year:     integer,
    fingerprint:         String.t,
    name:                String.t,
    security_code_check: boolean,
    created:             String.t,
    deleted:             boolean
  }

  @endpoint "cards"

  @doc ~S"""
  List all cards that belongs to the customer.

  Returns `{:ok, cards}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.
    * `order` - (optional, default: chronological) The order of the list returned.

  ## Examples

      Omise.Card.list("cust_test_520j6g67py52xa7qbu2")

  """
  @spec list(String.t, Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(customer_id, params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get("customers/#{customer_id}/#{@endpoint}", params, opts)
  end

  @doc ~S"""
  Retrieve a card.

  Returns `{:ok, card}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Card.retrieve("cust_test_520j6g67py52xa7qbu2", "card_test_520j6g4rxrmurw16b2d")

  """
  @spec retrieve(String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(customer_id, id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("customers/#{customer_id}/#{@endpoint}/#{id}", [], opts)
  end

  @doc ~S"""
  Update a card.

  Returns `{:ok, card}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `name` - (optional) The cardholder name as printed on the card.
    * `expiration_month` - (optional) The expiration month printed on the card.
    * `expiration_year` - (optional) The expiration year printed on the card in the format YYYY.
    * `postal_code` - (optional) The postal code from the city where the card was issued.
    * `city` - (optional) The city where the card was issued.

  ## Examples

      params = [expiration_month: 2018, city: "Bangkok"]
      Omise.Card.update("cust_test_520j6g67py52xa7qbu2", "card_test_520j6g4rxrmurw16b2d", params)

  """
  @spec update(String.t, String.t, Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def update(customer_id, id, params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    put("customers/#{customer_id}/#{@endpoint}/#{id}", params, opts)
  end

  @doc ~S"""
  Destroy a card.

  Returns `{:ok, card}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Card.destroy("cust_test_520j6g67py52xa7qbu2", "card_test_520j6g4rxrmurw16b2d")

  """
  @spec destroy(String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def destroy(customer_id, id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    delete("customers/#{customer_id}/#{@endpoint}/#{id}", opts)
  end
end
