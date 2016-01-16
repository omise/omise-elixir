defmodule Omise.Balance do
  @moduledoc """
  Balance struct.

  ## Reference:
  https://www.omise.co/balance-api
  """
  defstruct [:livemode, :location, :available, :total, :currency]
  @type t :: %__MODULE__{}
end
