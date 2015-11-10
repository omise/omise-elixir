defmodule Omise.Transfers do
  @moduledoc """
  Provides Transfers API interfaces.
  """

  @endpoint "transfers"

  @doc """
  List all transfers.

  Returns `{:ok, transfers}` if the request is successful, `{:error, error}` otherwise.

  Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      {:ok, transfers} = Omise.Transfers.list

      {:ok, transfers} = Omise.Transfers.list(limit: 5)

  """
  @spec list(Keyword.t) :: {:ok, List.t} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.make_request(:get, @endpoint, [params: params])
  end


  @doc """
  Create a transfer.

  Returns `{:ok, transfer}` if the request is successful, `{:error, error}` otherwise.

  Request Parameters:
    * `amount` - The amount in the smallest subunits of the currency used. So for thb (Thai Baht) you'll need to pass the amount in satangs.
    * `recipient` - The recipient id.

  ## Examples

      {:ok, transfer} = Omise.Transfers.create(amount: 100000)

      {:ok, transfer} = Omise.Transfers.create(amount: 100000, recipient: "recp_test_4z3wur7amjq2nbg8x44")

  """
  @spec create(Keyword.t) :: {:ok, Omise.Transfer.t} | {:error, Omise.Error.t}
  def create(params) do
    Omise.make_request(:post, @endpoint, [], {:form, params})
  end
end
