defmodule Omise.JapaneseBankAccount do
  @moduledoc """
  Omise Japanese Bank Account Object.
  """

  defstruct Omise.BankAccount.attributes ++
    [bank_code: nil, branch_code: nil, account_type: nil]

  @type t :: %__MODULE__{
    object:       String.t,
    bank_code:    String.t,
    branch_code:  String.t,
    account_type: String.t,
    last_digits:  String.t,
    name:         String.t,
    created:      String.t
  }
end
