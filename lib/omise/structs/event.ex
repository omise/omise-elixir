defmodule Omise.Event do
  @moduledoc """
  Event struct.

  ## Reference:
  https://www.omise.co/api-webhooks
  """
  defstruct [:id, :livemode, :location, :key, :created, :data]
  @type t :: %__MODULE__{}
end
