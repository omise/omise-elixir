defmodule Omise.V20140727.Customer do
  @moduledoc false

  defstruct [
    object:       "customer",
    id:           nil,
    livemode:     nil,
    location:     nil,
    default_card: nil,
    email:        nil,
    description:  nil,
    metadata:     %{},
    created:      nil,
    cards:        nil,
    deleted:      false
  ]

  @type t :: %__MODULE__{
    object:       String.t,
    id:           String.t,
    livemode:     boolean,
    location:     String.t,
    default_card: String.t,
    email:        String.t,
    description:  String.t,
    metadata:     map,
    created:      String.t,
    cards:        map,
    deleted:      boolean
  }

  defimpl Poison.Decoder do
    def decode(%{cards: cards} = customer, options) do
      decoded_cards = Omise.Decoder.decode(cards, options)

      %{customer | cards: decoded_cards}
    end
  end
end
