defmodule Omise.Charge do
  @moduledoc """
  Charge struct.

  ## Reference:
  https://www.omise.co/charges-api
  """
  defstruct [
    :id,
    :livemode,
    :amount,
    :currency,
    :description,
    :capture,
    :authorized,
    :captured,
    :paid,
    :transaction,
    :card,
    :refunded,
    :refunds,
    :failure_code,
    :failure_message,
    :customer,
    :ip,
    :dispute,
    :created,
    :return_uri,
    :return_uri
  ]
  @type t :: %__MODULE__{}
end
