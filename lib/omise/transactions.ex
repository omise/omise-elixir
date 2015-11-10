defmodule Omise.Transactions do
  @moduledoc """
  Provides Transactions API interfaces.
  """

  @endpoint "transactions"

  @doc """
  List all transactions.

  Returns `{:ok, transactions}` if the request is successful, `{:error, error}` otherwise.

  Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      {:ok, transactions} = Omise.Transactions.list

      {:ok, transactions} = Omise.Transactions.list(limit: 5)

  """
  @spec list(Keyword.t) :: {:ok, List.t} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.make_request(:get, @endpoint, [params: params])
  end

  @doc """
  Retrieve a transaction.

  Returns `{:ok, transaction}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, transaction} = Omise.Transactions.retrieve("trxn_test_51yg3xs2yggzsfbai3e")

      {:ok, transaction} = "trxn_test_51yg3xs2yggzsfbai3e" |> Omise.Transactions.retrieve

  """
  @spec retrieve(binary) :: {:ok, Omise.Transaction.t} | {:error, Omise.Error.t}
  def retrieve(id) do
    Omise.make_request(:get, "#{@endpoint}/#{id}")
  end
end
