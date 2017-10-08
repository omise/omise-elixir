defmodule Omise.V20140727.Charge do
  @moduledoc false

  defstruct [
    object:            "charge",
    id:                nil,
    livemode:          nil,
    location:          nil,
    amount:            nil,
    currency:          nil,
    description:       nil,
    metadata:          nil,
    status:            nil,
    capture:           nil,
    authorized:        nil,
    reversed:          nil,
    captured:          nil,
    transaction:       nil,
    source_of_fund:    nil,
    refunded:          nil,
    refunds:           nil,
    return_uri:        nil,
    offsite:           nil,
    offline:           nil,
    installment_terms: nil,

    reference:         nil,
    authorize_uri:     nil,

    failure_code:      nil,
    failure_message:   nil,
    card:              nil,
    customer:          nil,
    ip:                nil,
    dispute:           nil,
    created:           nil,
  ]

  @type t :: %__MODULE__{
    object:            String.t,
    id:                String.t,
    livemode:          boolean,
    location:          String.t,
    amount:            String.t,
    currency:          String.t,
    description:       String.t,
    metadata:          map,
    status:            String.t,
    capture:           boolean,
    authorized:        boolean,
    reversed:          boolean,
    captured:          boolean,
    transaction:       String.t,
    source_of_fund:    String.t,
    refunded:          String.t,
    refunds:           list,
    return_uri:        String.t,
    offsite:           String.t,
    offline:           map,
    installment_terms: integer,

    reference:         String.t,
    authorize_uri:     String.t,

    failure_code:      String.t,
    failure_message:   String.t,
    card:              map,
    customer:          Stringt.t,
    ip:                Stringt.t,
    dispute:           map,
    created:           Stringt.t,
  }

  defimpl Poison.Decoder do
    def decode(%{refunds: refunds, card: card, dispute: dispute} = charge, options) do
      [decoded_refunds, decode_card, decoded_dispute] = Enum.map([refunds, card, dispute], &(Omise.Decoder.decode(&1, options)))

      %{charge | refunds: decoded_refunds, card: decode_card, dispute: decoded_dispute}
    end
  end
end
