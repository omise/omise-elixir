defmodule Omise.Customers do
  @moduledoc """
  Provides Customers API interfaces.

  https://www.omise.co/customers-api
  """

  @endpoint "customers"

  @doc """
  List all customers.

  Returns `{:ok, customers}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      {:ok, customers} = Omise.Customers.list

  """
  @spec list(Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def list(params \\ []) do
    Omise.make_request(:get, @endpoint, [params: params])
  end

  @doc """
  Retrieve a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, customer} = Omise.Customers.retrieve("cust_test_4xtrb759599jsxlhkrb")

  """
  @spec retrieve(String.t) :: {:ok, Map.t} | {:error, Map.t}
  def retrieve(id) do
    Omise.make_request(:get, "#{@endpoint}/#{id}")
  end

  @doc """
  Create a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `email` - (optional) Customer's email.
    * `description` - (optional) A custom description for the customer.
    * `card` - (optional) A card token in case you want to add a card to the customer.

  ## Examples

      # Create a customer without attaching a card.
      {:ok, customer} = Omise.Customers.create(
        email: "edward@omistry.com",
        description: "Shut up, thief."
      )

      # Create a customer and attach a card.
      {:ok, customer} = Omise.Customers.create(
        email: "edward@omistry.com",
        description: "Shut up, thief.",
        card: "tokn_test_51yer81s9aqqyktdoeh"
      )

  """
  @spec create(Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def create(params) do
    Omise.make_request(:post, @endpoint, [], {:form, params})
  end

  @doc """
  Update a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `email` - (optional) Customer's email.
    * `description` - (optional) A custom description for the customer.
    * `card` - (optional) A card token in case you want to add a card to the customer.

  ## Examples

      # Update email and description.
      {:ok, customer} = Omise.Customers.update("cust_test_51yerhn3ghztgv31n4p", email: "edward@omistry.com", description: "Hello, it's me.")

      # Attach a card to a customer.
      {:ok, customer} = Omise.Customers.update("cust_test_4xtrb759599jsxlhkrb", card: "tokn_test_4xs9408a642a1htto8z")

  """
  @spec update(String.t, Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def update(id, params) do
    Omise.make_request(:patch, "#{@endpoint}/#{id}", [], {:form, params})
  end

  @doc """
  Destroy a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, customer} = Omise.Customers.destroy("cust_test_4xtrb759599jsxlhkrb")

  """
  @spec destroy(String.t) :: {:ok, Map.t} | {:error, Map.t}
  def destroy(id) do
    Omise.make_request(:delete, "#{@endpoint}/#{id}")
  end
end
