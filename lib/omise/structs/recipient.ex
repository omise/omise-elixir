defmodule Omise.Recipient do
  @moduledoc """
  Recipient struct.

  ## Reference:
  https://www.omise.co/recipients-api
  """
  defstruct [
    :id,
    :livemode,
    :location,
    :verified,
    :active,
    :name,
    :email,
    :description,
    :type,
    :tax_id,
    :bank_account,
    :failure_code,
    :created,
    :deleted
  ]
  @type t :: %__MODULE__{}
end
