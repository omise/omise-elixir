defmodule Omise.Transaction do
  @moduledoc ~S"""
  Provides Transaction API interfaces.

  <https://www.omise.co/transactions-api>
  """

  use Omise.HTTPClient, endpoint: "transactions"

  defstruct object: "transaction",
            id: nil,
            location: nil,
            type: nil,
            source: nil,
            amount: nil,
            currency: nil,
            transferable: nil,
            created: nil,
            direction: nil,
            key: nil,
            origin: nil

  @type t :: %__MODULE__{
          object: String.t(),
          id: String.t(),
          location: String.t(),
          type: String.t(),
          source: String.t(),
          amount: integer,
          currency: String.t(),
          transferable: String.t(),
          created: String.t(),
          direction: String.t(),
          key: String.t(),
          origin: String.t()
        }

  @doc ~S"""
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
  @spec list(Keyword.t(), Keyword.t()) :: {:ok, Omise.List.t()} | {:error, Omise.Error.t()}
  def list(params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get(@endpoint, params, opts)
  end

  @doc ~S"""
  Retrieve a transaction.

  Returns `{:ok, transaction}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Transaction.retrieve("trxn_test_51yg3xs2yggzsfbai3e")

  """
  @spec retrieve(String.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end
end
