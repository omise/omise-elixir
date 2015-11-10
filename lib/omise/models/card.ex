defmodule Omise.Card do
  @moduledoc """
  Card object.

  ## Reference:
  https://www.omise.co/cards-api
  """
  defstruct [
    :id,
    :livemode,
    :location,
    :country,
    :city,
    :postal_code,
    :financing,
    :last_digits,
    :brand,
    :expiration_month,
    :expiration_year,
    :fingerprint,
    :name,
    :created,
    :deleted
  ]
  @type t :: %__MODULE__{}
end
