defmodule Omise.Recipient do
  @moduledoc ~S"""
  Provides Recipient API interfaces.

  <https://www.omise.co/recipients-api>
  """

  import Omise.HTTP

  defstruct [
    object:       "recipient",
    id:           nil,
    livemode:     nil,
    location:     nil,
    verified:     nil,
    active:       nil,
    name:         nil,
    email:        nil,
    description:  nil,
    type:         nil,
    tax_id:       nil,
    bank_account: %Omise.BankAccount{},
    failure_code: nil,
    created:      nil,
    deleted:      false
  ]

  @type t :: %__MODULE__{
    object:       String.t,
    id:           String.t,
    livemode:     boolean,
    location:     String.t,
    verified:     boolean,
    active:       boolean,
    name:         String.t,
    email:        String.t,
    description:  String.t,
    type:         String.t,
    tax_id:       String.t,
    bank_account: Omise.BankAccount.t,
    failure_code: String.t,
    created:      String.t,
    deleted:      boolean
  }

  @endpoint "recipients"

  @doc ~S"""
  List all recipients.

  Returns `{:ok, recipients}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Recipient.list

      Omise.Recipient.list(limit: 5)

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get(@endpoint, params, opts)
  end

  @doc ~S"""
  Retrieve a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Recipient.retrieve("recp_test_4z6p7e0m4k40txecj5o")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end

  @doc ~S"""
  Create a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `name` - The recipient's name.
    * `email` - (optional) The recipient's email.
    * `description` - (optional) The recipient's description.
    * `type` - Either individual or corporation.
    * `tax_id` - (optional) The recipient's tax id.
    * `bank_account` - A valid bank account.

  ## Examples

      params = [
        name: "Nanna",
        email: "anna@omise.co",
        description: "Though the truth may vary, this ship will carry our bodies safe to shore",
        type: "individual",
        bank_account: [
          brand: "bbl",
          number: "1234567890",
          name: "Nanna"
        ]
      ]

      Omise.Recipient.create(params)

  """
  @spec create(Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def create(params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    post(@endpoint, params, opts)
  end

  @doc ~S"""
  Update a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `name` - The recipient's name.
    * `email` - (optional) The recipient's email.
    * `description` - (optional) The recipient's description.
    * `type` - Either individual or corporation.
    * `tax_id` - (optional) The recipient's tax id.
    * `bank_account` - A valid bank account.

  ## Examples

      params = [
        name: "Emma Stone",
        email: "emma@omise.co",
        bank_account: [
          brand: "kbank",
          name: "Emma Stone"
        ]
      ]

      Omise.Recipient.update("recp_test_4z6p7e0m4k40txecj5oparams", params)

  """
  @spec update(String.t, Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def update(id, params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    put("#{@endpoint}/#{id}", params, opts)
  end

  @doc ~S"""
  Destroy a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Recipient.destroy("recp_test_4z6p7e0m4k40txecj5o")

  """
  @spec destroy(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def destroy(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    delete("#{@endpoint}/#{id}", opts)
  end

  @doc ~S"""
  Search all the recipients.

  Returns `{:ok, recipients}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:

      <https://www.omise.co/search-query-and-filters>

  ## Examples

      Omise.Recipient.search(filters: [kind: "individual"])

      Omise.Recipient.search(query: "recp_235k46kl6ljl")

  """
  @spec search(Keyword.t, Keyword.t) :: {:ok, Omise.Search.t} | {:error, Omise.Error.t}
  def search(params \\ [], opts \\ []) do
    Omise.Search.execute("recipient", params, opts)
  end

  @doc ~S"""
  List all transfer schedules for a given recipient.

  Returns `{:ok, schedules}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Recipient.list_schedules("recp_test_556jkf7u174ptxuytac")

  """
  @spec list_schedules(String.t, Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list_schedules(id, params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%Omise.Schedule{}]})
    get("#{@endpoint}/#{id}/schedules", params, opts)
  end
end
