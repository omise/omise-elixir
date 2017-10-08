defmodule Omise.Event do
  @moduledoc ~S"""
  Provides Event API interfaces.

  <https://www.omise.co/events-api>
  """

  use Omise.HTTPClient, endpoint: "events"

  @doc ~S"""
  List all events.

  Returns `{:ok, events}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Event.list

      Omise.Event.list(limit: 10)

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list(params \\ [], options \\ []) do
    get(@endpoint, params, options)
  end

  @doc ~S"""
  Retrieve an event.

  Returns `{:ok, event}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Event.retrieve("evnt_test_5285sfiqfo8t32x6h5h")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(id, options \\ []) do
    get("#{@endpoint}/#{id}", [], options)
  end
end
