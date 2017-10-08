defmodule Omise.V20140727.List do
  @moduledoc false

  defstruct [
    object:   "list",
    from:     nil,
    to:       nil,
    offset:   nil,
    limit:    nil,
    total:    nil,
    order:    nil,
    location: nil,
    data:     []
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    from:     String.t,
    to:       String.t,
    offset:   integer,
    limit:    integer,
    total:    integer,
    order:    String.t,
    location: String.t,
    data:     list
  }

  defimpl Poison.Decoder do
    def decode(%{data: data} = list, options) do
      decoded_data = Omise.Decoder.decode(data, options)

      %{list | data: decoded_data}
    end
  end
end
