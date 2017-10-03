defmodule Omise.Receipt do
  @moduledoc ~S"""
  Provides Receipt API interfaces.

  <https://www.omise.co/receipt-api>
  """

  import Omise.HTTP

  defstruct [
    object:                  "receipt",
    id:                      nil,
    number:                  nil,
    location:                nil,
    date:                    nil,
    customer_name:           nil,
    customer_address:        nil,
    customer_tax_id:         nil,
    customer_email:          nil,
    customer_statement_name: nil,
    company_name:            nil,
    company_address:         nil,
    company_tax_id:          nil,
    charge_fee:              nil,
    voided_fee:              nil,
    transfer_fee:            nil,
    subtotal:                nil,
    vat:                     nil,
    wht:                     nil,
    total:                   nil,
    credit_note:             false,
    currency:                nil
  ]

  @type t :: %__MODULE__{
    object:                  String.t,
    id:                      String.t,
    number:                  String.t,
    location:                String.t,
    date:                    String.t,
    customer_name:           String.t,
    customer_address:        String.t,
    customer_tax_id:         String.t,
    customer_email:          String.t,
    customer_statement_name: String.t,
    company_name:            String.t,
    company_address:         String.t,
    company_tax_id:          String.t,
    charge_fee:              integer,
    voided_fee:              integer,
    transfer_fee:            integer,
    subtotal:                integer,
    vat:                     integer,
    wht:                     integer,
    total:                   integer,
    credit_note:             boolean,
    currency:                String.t
  }

  @endpoint "receipts"

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
  @spec list(Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get(@endpoint, params, opts)
  end

  @doc ~S"""
  Retrieve a receipt.

  Returns `{:ok, receipt}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Receipt.retrieve("rcpt_test_4z6p7e0m4k40txecj5o")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end
end
