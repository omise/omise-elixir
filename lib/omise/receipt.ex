defmodule Omise.Receipt do
  import Omise.HTTP

  defstruct [
    object:                  "receipt",
    id:                      nil,
    number:                  nil,
    location:                nil,
    date:                    nil,
    customer_name:            nil,
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
    customer_name:            String.t,
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

  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end
end
