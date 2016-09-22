defmodule Omise.Transaction do
  @moduledoc """
  Provides Transaction API interfaces.

  https://www.omise.co/transactions-api
  """

  defstruct [
    object:       "transaction",
    id:           nil,
    location:     nil,
    type:         nil,
    amount:       nil,
    currency:     nil,
    transferable: nil,
    created:      nil
  ]

  @type t :: %__MODULE__{
    object:       String.t,
    id:           String.t,
    location:     String.t,
    type:         String.t,
    amount:       integer,
    currency:     String.t,
    transferable: String.t,
    created:      String.t
  }

  @endpoint "transactions"

  @doc """
  List all transactions.

  Returns `{:ok, transactions}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Transaction.list

      Omise.Transaction.list(limit: 5)

  """
  @spec list(Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.HTTP.make_request(:get, @endpoint, params: params, as: %Omise.List{data: [%__MODULE__{}]})
  end

  @doc """
  Retrieve a transaction.

  Returns `{:ok, transaction}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Transaction.retrieve("trxn_test_51yg3xs2yggzsfbai3e")

  """
  @spec retrieve(String.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id) do
    Omise.HTTP.make_request(:get, "#{@endpoint}/#{id}", as: %__MODULE__{})
  end
end
