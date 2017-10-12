defmodule Omise.V20140727.Token do
  @moduledoc false

  defstruct [
    object:   "token",
    id:       nil,
    livemode: nil,
    location: nil,
    used:     nil,
    card:     nil,
    created:  nil
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    id:       String.t,
    livemode: boolean,
    location: String.t,
    used:     boolean,
    card:     map,
    created:  String.t
  }
end
