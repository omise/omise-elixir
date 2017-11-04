defmodule Omise.Refund do
  @moduledoc ~S"""
  Provides Refunds API interfaces.

  <https://www.omise.co/refunds-api>
  """

  use Omise.HTTPClient, endpoint: "refunds"

  defstruct object: "refund",
            id: nil,
            location: nil,
            amount: nil,
            currency: nil,
            voided: nil,
            charge: nil,
            transaction: nil,
            created: nil

  @type t :: %__MODULE__{
          object: String.t(),
          id: String.t(),
          location: String.t(),
          amount: integer,
          currency: String.t(),
          voided: boolean,
          charge: String.t(),
          transaction: String.t(),
          created: String.t()
        }

  @doc ~S"""
  List all refunds.

  Returns `{:ok, refunds}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Refund.list

  """
  @spec list(Keyword.t(), Keyword.t()) :: {:ok, Omise.List.t()} | {:error, Omise.Error.t()}
  def list(params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get(@endpoint, params, opts)
  end
end
