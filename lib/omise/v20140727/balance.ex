defmodule Omise.V20140727.Balance do
  @moduledoc false
  
  defstruct [
    object:    "balance",
    livemode:  nil,
    location:  nil,
    available: nil,
    total:     nil,
    currency:  nil
  ]

  @type t :: %__MODULE__{
    object:    String.t,
    livemode:  boolean,
    location:  String.t,
    available: integer,
    total:     integer,
    currency:  String.t
  }
end
