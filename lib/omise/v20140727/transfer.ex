defmodule Omise.V20140727.Transfer do
  @moduledoc false

  defstruct [
    object:          "transfer",
    id:              nil,
    livemode:        nil,
    location:        nil,
    recipient:       nil,
    bank_account:    nil,
    sent:            nil,
    paid:            nil,
    amount:          nil,
    currency:        nil,
    fee:             nil,
    failure_code:    nil,
    failure_message: nil,
    transaction:     nil,
    created:         nil,
    deleted:         false
  ]

  @type t :: %__MODULE__{
    object:          String.t,
    id:              String.t,
    livemode:        boolean,
    location:        String.t,
    recipient:       String.t,
    bank_account:    map,
    sent:            boolean,
    paid:            boolean,
    amount:          integer,
    currency:        String.t,
    fee:             integer,
    failure_code:    String.t,
    failure_message: String.t,
    transaction:     String.t,
    created:         String.t,
    deleted:         boolean
  }

  defimpl Poison.Decoder do
    def decode(%{bank_account: bank_account} = transfer, options) do
      decoded_bank_account = Omise.Decoder.decode(bank_account, options)

      %{transfer | bank_account: decoded_bank_account}
    end
  end
end
