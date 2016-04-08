defmodule Omise.Cards do
  @moduledoc """
  Provides Cards API interfaces.

  https://www.omise.co/cards-api
  """

  @endpoint "cards"

  @doc """
  List all cards that belongs to the customer.

  Returns `{:ok, cards}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.
    * `order` - (optional, default: chronological) The order of the list returned.

  ## Examples

      {:ok, cards} = Omise.Cards.list("cust_test_520j6g67py52xa7qbu2")

  """
  @spec list(String.t, Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def list(customer_id, params \\ []) do
    Omise.make_request(:get, "customers/#{customer_id}/#{@endpoint}", [params: params])
  end

  @doc """
  Retrieve a card.

  Returns `{:ok, card}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, card} = Omise.Cards.retrieve("cust_test_520j6g67py52xa7qbu2", "card_test_520j6g4rxrmurw16b2d")

  """
  @spec retrieve(String.t, String.t) :: {:ok, Map.t} | {:error, Map.t}
  def retrieve(customer_id, id) do
    Omise.make_request(:get, "customers/#{customer_id}/#{@endpoint}/#{id}")
  end

  @doc """
  Update a card.

  Returns `{:ok, card}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `name` - (optional) The cardholder name as printed on the card.
    * `expiration_month` - (optional) The expiration month printed on the card.
    * `expiration_year` - (optional) The expiration year printed on the card in the format YYYY.
    * `postal_code` - (optional) The postal code from the city where the card was issued.
    * `city` - (optional) The city where the card was issued.

  ## Examples

      {:ok, updated_card} = Omise.Cards.update(
        "cust_test_520j6g67py52xa7qbu2",
        "card_test_520j6g4rxrmurw16b2d",
        name: "George Ezra", city: "London"
      )

  """
  @spec update(String.t, String.t, Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def update(customer_id, card_id, params) do
    Omise.make_request(:patch, "customers/#{customer_id}/#{@endpoint}/#{card_id}", [], {:form, params})
  end

  @doc """
  Destroy a card.

  Returns `{:ok, card}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, card} = Omise.Cards.destroy(
        "cust_test_520j6g67py52xa7qbu2",
        "card_test_520j6g4rxrmurw16b2d"
      )

  """
  @spec destroy(String.t, String.t) :: {:ok, Map.t} | {:error, Map.t}
  def destroy(customer_id, card_id) do
    Omise.make_request(:delete, "customers/#{customer_id}/#{@endpoint}/#{card_id}")
  end
end
