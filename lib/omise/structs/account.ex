defmodule Omise.Account do
  @moduledoc """
  Account struct.

  ## Reference:
  https://www.omise.co/account-api
  """
  defstruct [:id, :email, :created]
  @type t :: %__MODULE__{}
end
