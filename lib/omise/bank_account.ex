defmodule Omise.BankAccount do
  @moduledoc """
  Omise Bank Account Object.

  https://www.omise.co/bank-account-api
  """

  defstruct [
    object:       "bank_account",
    last_digits:  nil,
    name:         nil,
    created:      nil,
    brand:        nil,
    bank_code:    nil,
    branch_code:  nil,
    account_type: nil,
  ]

  @type t :: %__MODULE__{
    object:       String.t,
    last_digits:  String.t,
    name:         String.t,
    created:      String.t,
    brand:        String.t,
    bank_code:    String.t,
    branch_code:  String.t,
    account_type: String.t
  }
end
