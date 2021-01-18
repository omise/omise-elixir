defmodule Omise.PaymentMethod do
  @moduledoc ~S"""
  Provides Barcode API interfaces.
  """

  defstruct object: "payment_method",
            name: nil,
            currencies: nil,
            card_brands: nil,
            installment_terms: nil

  @type t :: %__MODULE__{
          object: String.t(),
          name: nil,
          currencies: list,
          card_brands: list,
          installment_terms: list
        }
end
