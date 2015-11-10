defmodule Omise.Error do
  @moduledoc """
  Error object.

  ## Reference:
  https://www.omise.co/api-errors
  """
  defstruct [:code, :message, :location]
  @type t :: %__MODULE__{}
end
