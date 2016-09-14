defmodule Omise.Recipient do
  @moduledoc """
  Provides Recipient API interfaces.

  https://www.omise.co/recipients-api
  """

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
    bank_account: nil,
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

  @doc """
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
  @spec list(Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.HTTP.make_request(:get, @endpoint, params: params, as: %Omise.List{data: [%__MODULE__{}]})
  end

  @doc """
  Retrieve a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Recipient.retrieve("recp_test_4z6p7e0m4k40txecj5o")

  """
  @spec retrieve(String.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def retrieve(id) do
    Omise.HTTP.make_request(:get, "#{@endpoint}/#{id}", as: %__MODULE__{})
  end

  @doc """
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
  @spec create(Keyword.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def create(params) do
    normalized_params = Omise.Utils.normalize_recipient_params(params)
    Omise.HTTP.make_request(:post, @endpoint, body: {:form, normalized_params}, as: %__MODULE__{})
  end

  @doc """
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
  @spec update(String.t, Keyword.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def update(id, params) do
    normalized_params = Omise.Utils.normalize_recipient_params(params)
    Omise.HTTP.make_request(:patch, "#{@endpoint}/#{id}", body: {:form, normalized_params}, as: %__MODULE__{})
  end

  @doc """
  Destroy a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Recipient.destroy("recp_test_4z6p7e0m4k40txecj5o")

  """
  @spec destroy(String.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def destroy(id) do
    Omise.HTTP.make_request(:delete, "#{@endpoint}/#{id}", as: %__MODULE__{})
  end

  @doc """
  Search all the recipients.

  Returns `{:ok, recipients}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:

      https://www.omise.co/search-query-and-filters

  ## Examples

      Omise.Recipient.search(filters: [kind: "individual"])

      Omise.Recipient.search(query: "recp_235k46kl6ljl")

  """
  @spec search(Keyword.t) :: {:ok, Omise.Search.t} | {:error, Omise.Error.t}
  def search(params \\ []) do
    Omise.Search.execute("recipient", params)
  end
end
