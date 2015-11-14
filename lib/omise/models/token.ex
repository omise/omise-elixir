defmodule Omise.Token do
  @moduledoc """
  Token object.

  ## Reference:
  https://www.omise.co/tokens-api
  """
  defstruct [:id, :livemode, :location, :used, :card, :created]
  @type t :: %__MODULE__{}
end
