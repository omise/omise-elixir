defmodule Omise.Token do
  @moduledoc """
  Token object.

  ## Reference:
  https://www.omise.co/tokens-api

  ## NOTE:
  Do not send the credit card data to Omise from your servers directly.
  You must send the card data from the client browser via Javascript (Omise-JS).
  """
  defstruct [:id, :livemode, :location, :used, :card, :created]
  @type t :: %__MODULE__{}
end
