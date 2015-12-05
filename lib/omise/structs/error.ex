defmodule Omise.Error do
  @moduledoc """
  Error struct.

  ## Reference:
  https://www.omise.co/api-errors
  """
  defstruct [:code, :message, :location]
  @type t :: %__MODULE__{}
end
