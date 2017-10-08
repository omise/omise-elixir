defmodule Omise.Transfer do
  @moduledoc ~S"""
  Provides Transfers API interfaces.

  <https://www.omise.co/transfers-api>
  """

  use Omise.HTTPClient, endpoint: "transfers"

  @doc ~S"""
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
  @spec list(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list(params \\ [], options \\ []) do
    get(@endpoint, params, options)
  end

  @doc ~S"""
  Retrieve a transfer.

  Returns `{:ok, transfer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Transfer.retrieve("trsf_test_5086uxn23hfaxv8nl0f")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(id, options \\ []) do
    get("#{@endpoint}/#{id}", [], options)
  end

  @doc ~S"""
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
  @spec create(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def create(params, options \\ []) do
    post(@endpoint, params, options)
  end

  @doc ~S"""
  Update a transfer.

  Returns `{:ok, transfer}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `amount` - The amount in the smallest subunits of the currency used.

  ## Examples

      Omise.Transfer.update("trsf_test_5086uxn23hfaxv8nl0f", amount: 500_00)

  """
  @spec update(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def update(id, params, options \\ []) do
    put("#{@endpoint}/#{id}", params, options)
  end

  @doc ~S"""
  Destroy a transfer.

  Returns `{:ok, transfer}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Transfer.destroy("trsf_test_5086uxn23hfaxv8nl0f")

  """
  @spec destroy(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def destroy(id, options \\ []) do
    delete("#{@endpoint}/#{id}", options)
  end

  @doc ~S"""
  List all transfer schedules.

  Returns `{:ok, schedules}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Transfer.list_schedules

  """
  @spec list_schedules(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list_schedules(params \\ [], options \\ []) do
    get("#{@endpoint}/schedules", params, options)
  end
end
