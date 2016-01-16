defmodule Omise.Transaction do
  @moduledoc """
  Transaction struct.

  ## Reference:
  https://www.omise.co/transactions-api
  """
  defstruct [:id, :location, :type, :amount, :currency, :transferable, :created]
  @type t :: %__MODULE__{}
end
