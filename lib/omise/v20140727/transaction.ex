defmodule Omise.V20140727.Transaction do
  @moduledoc false

  defstruct [
    object:       "transaction",
    id:           nil,
    location:     nil,
    type:         nil,
    source:       nil,
    amount:       nil,
    currency:     nil,
    transferable: nil,
    created:      nil
  ]

  @type t :: %__MODULE__{
    object:       String.t,
    id:           String.t,
    location:     String.t,
    type:         String.t,
    source:       String.t,
    amount:       integer,
    currency:     String.t,
    transferable: String.t,
    created:      String.t
  }
end
