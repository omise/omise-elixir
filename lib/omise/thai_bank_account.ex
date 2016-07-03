defmodule Omise.ThaiBankAccount do
  @moduledoc """
  Omise Thai Bank Account Object.
  """

  defstruct Omise.BankAccount.attributes ++
    [brand: nil]

  @type t :: %__MODULE__{
    object:      String.t,
    brand:       String.t,
    last_digits: String.t,
    name:        String.t,
    created:     String.t
  }
end
