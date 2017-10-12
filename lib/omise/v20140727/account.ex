defmodule Omise.V20140727.Account do
  @moduledoc false

  defstruct [
    object:               "account",
    id:                   nil,
    livemode:             nil,
    location:             nil,
    email:                nil,
    currency:             nil,
    supported_currencies: nil,
    created:              nil,
  ]

  @type t :: %__MODULE__{
    object:               String.t,
    id:                   String.t,
    livemode:             boolean,
    location:             String.t,
    email:                String.t,
    currency:             String.t,
    supported_currencies: list,
    created:              String.t,
  }
end
