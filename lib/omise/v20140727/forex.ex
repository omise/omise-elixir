defmodule Omise.V20140727.Forex do
  @moduledoc false

  defstruct [
    object:   "forex",
    from:     nil,
    to:       nil,
    rate:     nil,
    location: nil,
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    from:     String.t,
    to:       String.t,
    rate:     float,
    location: String.t,
  }
end
