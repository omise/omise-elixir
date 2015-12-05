defmodule Omise.Refund do
  @moduledoc """
  Refund struct.

  ## Reference:
  https://www.omise.co/refunds-api
  """
  defstruct [
    :id,
    :livemode,
    :amount,
    :currency,
    :transaction,
    :charge,
    :created
  ]
  @type t :: %__MODULE__{}
end
