defmodule Omise.Balance do
  @moduledoc """
  Balance object.

  ## Reference:
  https://www.omise.co/balance-api
  """
  defstruct [:livemode, :available, :total, :currency]
  @type t :: %__MODULE__{}
end
