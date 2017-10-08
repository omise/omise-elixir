defmodule Omise.V20140727.Link do
  @moduledoc false

  defstruct [
    object:      "link",
    id:          nil,
    livemode:    nil,
    location:    nil,
    amount:      nil,
    currency:    nil,
    used:        nil,
    multiple:    nil,
    title:       nil,
    description: nil,
    charges:     nil,
    payment_uri: nil,
    created:     nil
  ]

  @type t :: %__MODULE__{
    object:      String.t,
    id:          String.t,
    livemode:    boolean,
    location:    String.t,
    amount:      integer,
    currency:    String.t,
    used:        boolean,
    multiple:    boolean,
    title:       String.t,
    description: String.t,
    charges:     map,
    payment_uri: String.t,
    created:     String.t
  }

  defimpl Poison.Decoder do
    def decode(%{charges: charges} = link, options) do
      decoded_charges = Omise.Decoder.decode(charges, options)

      %{link | charges: decoded_charges}
    end
  end
end
