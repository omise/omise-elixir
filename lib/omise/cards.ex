defmodule Omise.Cards do
  @moduledoc """
  Provides Cards API interfaces.
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

      {:ok, customer} = Omise.Customers.retrieve("cust_test_520j6g67py52xa7qbu2")
      {:ok, cards} = customer |> Omise.Cards.list

  """
  @spec list(Omise.Customer.t, Keyword.t) :: {:ok, [Omise.Card.t]} | {:error, Omise.Error.t}
  def list(customer, params \\ []) do
    Omise.make_request(:get, "customers/#{customer.id}/#{@endpoint}", [params: params])
  end

  @doc """
  Retrieve a card.

  Returns `{:ok, card}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, customer} = Omise.Customers.retrieve("cust_test_520j6g67py52xa7qbu2")
      {:ok, card} = customer |> Omise.Cards.retrieve("card_test_520j6g4rxrmurw16b2d")

  """
  @spec retrieve(Omise.Customer.t, String.t) :: {:ok, Omise.Card.t} | {:error, Omise.Error.t}
  def retrieve(customer, id) do
    Omise.make_request(:get, "customers/#{customer.id}/#{@endpoint}/#{id}")
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

      {:ok, customer} = Omise.Customers.retrieve("cust_test_520j6g67py52xa7qbu2")
      {:ok, card} = customer |> Omise.Cards.retrieve("card_test_520j6g4rxrmurw16b2d")
      {:ok, updated_card} = customer |> Omise.Cards.update(card, name: "George Ezra", city: "London")

  """
  @spec update(Omise.Customer.t, Omise.Card.t, Keyword.t) :: {:ok, Omise.Card.t} | {:error, Omise.Error.t}
  def update(customer, card, params) do
    Omise.make_request(:patch, "customers/#{customer.id}/#{@endpoint}/#{card.id}", [], {:form, params})
  end

  @doc """
  Destroy a card.

  Returns `{:ok, card}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, customer} = Omise.Customers.retrieve("cust_test_520j6g67py52xa7qbu2")
      {:ok, card} = customer |> Omise.Cards.retrieve("card_test_520j6g4rxrmurw16b2d")
      {:ok, updated_card} = customer |> Omise.Cards.destroy(card)

  """
  @spec destroy(Omise.Customer.t, Omise.Card.t) :: {:ok, Omise.Card.t} | {:error, Omise.Error.t}
  def destroy(customer, card) do
    Omise.make_request(:delete, "customers/#{customer.id}/#{@endpoint}/#{card.id}")
  end
end
