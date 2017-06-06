defmodule Omise.Dispute do
  @moduledoc ~S"""
  Provides Dispute API interfaces.

  <https://www.omise.co/disputes-api>
  """

  use Omise.Document, resource: "disputes"

  import Omise.HTTP

  defstruct [
    object:   "dispute",
    id:       nil,
    livemode: nil,
    location: nil,
    amount:   nil,
    currency: nil,
    status:   nil,
    message:  nil,
    charge:   nil,
    created:  nil
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    id:       String.t,
    livemode: boolean,
    location: String.t,
    amount:   integer,
    currency: String.t,
    status:   String.t,
    message:  String.t,
    charge:   String.t,
    created:  String.t
  }

  @endpoint "disputes"

  @doc ~S"""
  List all disputes.

  Returns `{:ok, disputes}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples
      # List all disputes
      Omise.Dispute.list

      # List all open disputes
      Omise.Dispute.list(status: "open")

      # List all pending disputes
      Omise.Dispute.list(status: "pending")

      # List all closed disputes
      Omise.Dispute.list(status: "closed")

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ [], opts \\ []) do
    status = params[:status] || ""
    opts   = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get("#{@endpoint}/#{status}", params, opts)
  end

  @doc ~S"""
  Retrieve a dispute.

  Returns `{:ok, dispute}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Dispute.retrieve("dspt_test_51yfnnpsxajeybpytm4")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end

  @doc ~S"""
  Update a dispute.

  Returns `{:ok, dispute}` if the request is successful, `{:error, error}` otherwise.

  Request Parameter:
    * `message` - The new dispute message.

  ## Examples

      Omise.Dispute.update("dspt_test_4zgf15h89w8t775kcm8", message: "Shut up and dance with me!")

  """
  @spec update(String.t, Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def update(id, params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    put("#{@endpoint}/#{id}", params, opts)
  end

  @doc ~S"""
  Search all the disputes.

  Returns `{:ok, disputes}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:

      <https://www.omise.co/search-query-and-filters>

  ## Examples

      Omise.Dispute.search(filters: [status: "pending"])

      Omise.Dispute.search(query: "dspt_5089off452g5m5te7xs")

  """
  @spec search(Keyword.t, Keyword.t) :: {:ok, Omise.Search.t} | {:error, Omise.Error.t}
  def search(params \\ [], opts \\ []) do
    Omise.Search.execute("dispute", params, opts)
  end
end
