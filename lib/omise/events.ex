defmodule Omise.Events do
  @moduledoc """
  Provides Events API interfaces.
  """

  @endpoint "events"

  @doc """
  List all events.

  Returns `{:ok, events}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      {:ok, events} = Omise.Events.list

      {:ok, events} = Omise.Events.list(limit: 10)

  """
  @spec list(Keyword.t) :: {:ok, [Omise.Event.t]} | {:error, Omise.Error.t}
  def list(params \\ []) do
    Omise.make_request(:get, @endpoint, [params: params])
  end

  @doc """
  Retrieve an event.

  Returns `{:ok, event}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, event} = Omise.Events.retrieve("evnt_test_5285sfiqfo8t32x6h5h")

  """
  @spec retrieve(String.t) :: {:ok, Omise.Event.t} | {:error, Omise.Error.t}
  def retrieve(id) do
    Omise.make_request(:get, "#{@endpoint}/#{id}")
  end
end
