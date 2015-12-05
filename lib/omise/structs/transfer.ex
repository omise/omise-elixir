defmodule Omise.Transfer do
  @moduledoc """
  Transfer struct.

  ## Reference:
  https://www.omise.co/transfers-api
  """
  defstruct [
    :id,
    :livemode,
    :location,
    :recipient,
    :bank_account,
    :sent,
    :paid,
    :amount,
    :currency,
    :failure_code,
    :failure_message,
    :transaction,
    :created
  ]
  @type t :: %__MODULE__{}
end
