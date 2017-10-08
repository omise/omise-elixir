defmodule Omise.V20140727.Dispute do
  @moduledoc false

  defstruct [
    object:         "dispute",
    id:             nil,
    livemode:       nil,
    location:       nil,
    amount:         nil,
    currency:       nil,
    status:         nil,
    message:        nil,
    reason_code:    nil,
    reason_message: nil,
    charge:         nil,
    documents:      nil,
    created:        nil,
    closed_at:      nil,
  ]

  @type t :: %__MODULE__{
    object:         String.t,
    id:             String.t,
    livemode:       boolean,
    location:       String.t,
    amount:         integer,
    currency:       String.t,
    status:         String.t,
    reason_code:    String.t,
    reason_message: String.t,
    message:        String.t,
    charge:         String.t,
    documents:      list,
    created:        String.t,
    closed_at:      String.t,
  }

  defimpl Poison.Decoder do
    def decode(%{documents: documents} = dispute, options) do
      decoded_documents = Omise.Decoder.decode(documents, options)

      %{dispute | documents: decoded_documents}
    end
  end
end
