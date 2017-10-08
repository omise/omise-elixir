defmodule Omise.V20140727.Chain do
  @moduledoc false

  defstruct [
    object:   "chain",
    id:       nil,
    livemode: nil,
    revoked:  nil,
    key:      nil,
    email:    nil,
    created:  nil,
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    id:       String.t,
    livemode: boolean,
    revoked:  boolean,
    key:      String.t,
    email:    String.t,
    created:  String.t,
  }
end
