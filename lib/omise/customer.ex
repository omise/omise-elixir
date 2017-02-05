defmodule Omise.Customer do
  @moduledoc ~S"""
  Provides Customer API interfaces.

  https://www.omise.co/customers-api
  """

  import Omise.HTTP

  defstruct [
    object:       "customer",
    id:           nil,
    livemode:     nil,
    location:     nil,
    default_card: nil,
    email:        nil,
    description:  nil,
    created:      nil,
    cards:        %Omise.List{data: [%Omise.Card{}]},
    deleted:      false
  ]

  @type t :: %__MODULE__{
    object:       String.t,
    id:           String.t,
    livemode:     boolean,
    location:     String.t,
    default_card: String.t,
    email:        String.t,
    description:  String.t,
    created:      String.t,
    cards:        Omise.List.t,
    deleted:      boolean
  }

  @endpoint "customers"

  @doc ~S"""
  List all customers.

  Returns `{:ok, customers}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Customer.list

      Omise.Customer.list(limit: 5)

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get(@endpoint, params, opts)
  end

  @doc ~S"""
  Retrieve a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Customer.retrieve("cust_test_4xtrb759599jsxlhkrb")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end

  @doc ~S"""
  Create a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `email` - (optional) Customer's email.
    * `description` - (optional) A custom description for the customer.
    * `card` - (optional) A card token in case you want to add a card to the customer.

  ## Examples

      # Create a customer without attaching a card
      Omise.Customer.create(
        email: "lucius@omise.co",
        description: "You know, it almost makes me wish for rain"
      )

      # Create a customer and attach a card
      Omise.Customer.create(
        email: "grouplove@omise.co",
        description: "Don't take me tongue tied",
        card: "tokn_test_51yer81s9aqqyktdoeh"
      )

  """
  @spec create(Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def create(params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    post(@endpoint, params, opts)
  end

  @doc ~S"""
  Update a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `email` - (optional) Customer's email.
    * `description` - (optional) A custom description for the customer.
    * `card` - (optional) A card token in case you want to add a card to the customer.

  ## Examples

      # Update email and description.
      Omise.Customer.update("cust_test_51yerhn3ghztgv31n4p",
        email: "edward@omise.co",
        description: "Home is when I’m alone with you"
      )

      # Attach a card to a customer.
      Omise.Customer.update("cust_test_4xtrb759599jsxlhkrb",
        card: "tokn_test_4xs9408a642a1htto8z"
      )

  """
  @spec update(String.t, Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def update(id, params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    put("#{@endpoint}/#{id}", params, opts)
  end

  @doc ~S"""
  Destroy a customer.

  Returns `{:ok, customer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Customer.destroy("cust_test_4xtrb759599jsxlhkrb")

  """
  @spec destroy(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def destroy(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    delete("#{@endpoint}/#{id}", opts)
  end

  @doc ~S"""
  Search all the customers.

  Returns `{:ok, customers}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:

      https://www.omise.co/search-query-and-filters

  ## Examples

      Omise.Customer.search(filters: [created: "2016-09-09"])

      Omise.Customer.search(query: "eleven@omise.co")

  """
  @spec search(Keyword.t, Keyword.t) :: {:ok, Omise.Search.t} | {:error, Omise.Error.t}
  def search(params \\ [], opts \\ []) do
    Omise.Search.execute("customer", params, opts)
  end
end
