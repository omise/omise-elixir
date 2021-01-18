defmodule Omise.Reference do
  @moduledoc ~S"""
  Provides Reference API interfaces.
  """

  defstruct expires_at: nil,
            customer_amount: nil,
            device_id: nil,
            customer_currency: nil,
            customer_exchange_rate: nil,
            omise_tax_id: nil,
            reference_number_1: nil,
            reference_number_2: nil,
            barcode: nil,
            payment_code: nil,
            va_code: nil

  @type t :: %__MODULE__{
          expires_at: String.t(),
          customer_amount: integer,
          device_id: String.t(),
          customer_currency: String.t(),
          customer_exchange_rate: float,
          omise_tax_id: String.t(),
          reference_number_1: String.t(),
          reference_number_2: String.t(),
          barcode: String.t(),
          va_code: String.t()
        }
end
