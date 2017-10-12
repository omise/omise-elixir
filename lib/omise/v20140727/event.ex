defmodule Omise.V20140727.Event do
  @moduledoc false

  defstruct [
    object:   "event",
    id:       nil,
    livemode: nil,
    location: nil,
    key:      nil,
    created:  nil,
    data:     nil
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    id:       String.t,
    livemode: boolean,
    location: String.t,
    key:      String.t,
    created:  String.t,
    data:     map
  }

  defimpl Poison.Decoder do
    def decode(%{data: data} = event, options) do
      decoded_data = Omise.Decoder.decode(data, options)

      %{event | data: decoded_data}
    end
  end
end
