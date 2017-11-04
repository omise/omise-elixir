defmodule Omise.BankAccount do
  @moduledoc ~S"""
  Omise Bank Account Struct.

  <https://www.omise.co/bank-account-api>
  """

  defstruct object: "bank_account",
            brand: nil,
            bank_code: nil,
            branch_code: nil,
            account_type: nil,
            last_digits: nil,
            name: nil,
            created: nil,
            deleted: false

  @type t :: %__MODULE__{
          object: String.t(),
          brand: String.t(),
          bank_code: String.t(),
          branch_code: String.t(),
          account_type: String.t(),
          last_digits: String.t(),
          name: String.t(),
          created: String.t(),
          deleted: boolean
        }
end
