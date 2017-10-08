defmodule Omise.V20140727.Recipient do
  @moduledoc false

  defstruct [
    object:       "recipient",
    id:           nil,
    livemode:     nil,
    location:     nil,
    verified:     nil,
    active:       nil,
    name:         nil,
    email:        nil,
    description:  nil,
    type:         nil,
    tax_id:       nil,
    bank_account: nil,
    failure_code: nil,
    created:      nil,
    deleted:      false
  ]

  @type t :: %__MODULE__{
    object:       String.t,
    id:           String.t,
    livemode:     boolean,
    location:     String.t,
    verified:     boolean,
    active:       boolean,
    name:         String.t,
    email:        String.t,
    description:  String.t,
    type:         String.t,
    tax_id:       String.t,
    bank_account: map,
    failure_code: String.t,
    created:      String.t,
    deleted:      boolean
  }

  defimpl Poison.Decoder do
    def decode(%{bank_account: bank_account} = recipient, options) do
      decoded_bank_account = Omise.Decoder.decode(bank_account, options)

      %{recipient | bank_account: decoded_bank_account}
    end
  end
end
