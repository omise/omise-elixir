defmodule Omise.V20140727.Refund do
  @moduledoc false

  defstruct [
    object:      "refund",
    id:          nil,
    location:    nil,
    amount:      nil,
    currency:    nil,
    voided:      nil,
    charge:      nil,
    transaction: nil,
    created:     nil
  ]

  @type t :: %__MODULE__{
    object:      String.t,
    id:          String.t,
    location:    String.t,
    amount:      integer,
    currency:    String.t,
    voided:      boolean,
    charge:      String.t,
    transaction: String.t,
    created:     String.t
  }
end
