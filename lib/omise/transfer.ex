defmodule Omise.Transfer do
  @moduledoc """
  Provides Transfers API interfaces.

  https://www.omise.co/transfers-api
  """

  defstruct [
    object:          "transfer",
    id:              nil,
    livemode:        nil,
    location:        nil,
    recipient:       nil,
    bank_account:    nil,
    sent:            nil,
    paid:            nil,
    amount:          nil,
    currency:        nil,
    fee:             nil,
    failure_code:    nil,
    failure_message: nil,
    transaction:     nil,
    created:         nil,
    deleted:         false
  ]

  @type t :: %__MODULE__{
    object:          String.t,
    id:              String.t,
    livemode:        boolean,
    location:        String.t,
    recipient:       String.t,
    bank_account:    Omise.BankAccount.t,
    sent:            boolean,
    paid:            boolean,
    amount:          integer,
    currency:        String.t,
    fee:             integer,
    failure_code:    String.t,
    failure_message: String.t,
    transaction:     String.t,
    created:         String.t,
    deleted:         boolean
  }

  @endpoint "transfers"

  @doc """
  List all transfers.

  Returns `{:ok, transfers}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Transfer.list

      Omise.Transfer.list(limit: 5)

  """
  @spec list(Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.HTTP.make_request(:get, @endpoint, params: params, as: %Omise.List{data: [%__MODULE__{}]})
  end

  @doc """
  Retrieve a transfer.

  Returns `{:ok, transfer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Transfer.retrieve("trsf_test_5086uxn23hfaxv8nl0f")

  """
  @spec retrieve(String.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id) do
    Omise.HTTP.make_request(:get, "#{@endpoint}/#{id}", as: %__MODULE__{})
  end

  @doc """
  Create a transfer.

  Returns `{:ok, transfer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `amount` - The amount in the smallest subunits of the currency used. So for thb (Thai Baht) you'll need to pass the amount in satangs.
    * `recipient` - The recipient id.

  ## Examples
      # Create a transfer to a default recipient
      Omise.Transfer.create(amount: 1000_00)

      # Create a transfer to a third-party recipient
      Omise.Transfer.create(
        amount: 1000_00,
        recipient: "recp_test_4z3wur7amjq2nbg8x44"
      )

  """
  @spec create(Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def create(params) do
    Omise.HTTP.make_request(:post, @endpoint, body: {:form, params}, as: %__MODULE__{})
  end

  @doc """
  Update a transfer.

  Returns `{:ok, transfer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `amount` - The amount in the smallest subunits of the currency used.

  ## Examples

      Omise.Transfer.update("trsf_test_5086uxn23hfaxv8nl0f", amount: 500_00)

  """
  @spec update(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def update(id, params) do
    Omise.HTTP.make_request(:patch, "#{@endpoint}/#{id}", body: {:form, params}, as: %__MODULE__{})
  end

  @doc """
  Destroy a transfer.

  Returns `{:ok, transfer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Transfer.destroy("trsf_test_5086uxn23hfaxv8nl0f")

  """
  @spec destroy(String.t) :: {:ok, t} | {:error, Omise.Error.t}
  def destroy(id) do
    Omise.HTTP.make_request(:delete, "#{@endpoint}/#{id}", as: %__MODULE__{})
  end
end
