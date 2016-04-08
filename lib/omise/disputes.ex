defmodule Omise.Disputes do
  @moduledoc """
  Provides Disputes API interfaces.

  https://www.omise.co/disputes-api
  """

  @endpoint "disputes"

  @doc """
  List all disputes.

  Returns `{:ok, disputes}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      {:ok, all_disputes}     = Omise.Disputes.list

      {:ok, open_disputes}    = Omise.Disputes.list(status: "open")

      {:ok, pending_disputes} = Omise.Disputes.list(status: "pending")

      {:ok, closed_isputes}   = Omise.Disputes.list(status: "closed")

  """
  @spec list(Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def list(params \\ []) do
    status = params[:status] || ""
    Omise.make_request(:get, "#{@endpoint}/#{status}",  [params: params])
  end

  @doc """
  Retrieve a dispute.

  Returns `{:ok, dispute}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, dispute} = Omise.Disputes.retrieve("dspt_test_51yfnnpsxajeybpytm4")

  """
  @spec retrieve(String.t) :: {:ok, Map.t} | {:error, Map.t}
  def retrieve(id) do
    Omise.make_request(:get, "#{@endpoint}/#{id}")
  end

  @doc """
  Update a dispute.

  Returns `{:ok, dispute}` if the request is successful, `{:error, error}` otherwise.

  Request Parameter:
    * `message` - The new dispute message.

  ## Examples

      {:ok, dispute} = Omise.Disputes.update("dspt_test_4zgf15h89w8t775kcm8", message: "Hello, it's me")

  """
  @spec update(String.t, Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def update(id, params) do
    Omise.make_request(:patch, "#{@endpoint}/#{id}", [], {:form, params})
  end
end
