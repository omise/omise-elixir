defmodule Omise.Receipt do
  @moduledoc ~S"""
  Provides Receipt API interfaces.

  <https://www.omise.co/receipt-api>
  """

  use Omise.HTTPClient, endpoint: "receipts"

  @doc ~S"""
  List all receipts.

  Returns `{:ok, receipts}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Receipt.list

      Omise.Receipt.list(limit: 5)

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list(params \\ [], options \\ []) do
    get(@endpoint, params, options)
  end

  @doc ~S"""
  Retrieve a receipt.

  Returns `{:ok, receipt}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Receipt.retrieve("rcpt_test_4z6p7e0m4k40txecj5o")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(id, options \\ []) do
    get("#{@endpoint}/#{id}", [], options)
  end
end
