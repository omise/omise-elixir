defmodule Omise.Dispute do
  @moduledoc """
  Dispute struct.

  ## Reference:
  https://www.omise.co/disputes-api
  """
  defstruct [
    :id,
    :livemode,
    :location,
    :amount,
    :currency,
    :status,
    :message,
    :charge,
    :created
  ]
  @type t :: %__MODULE__{}
end
