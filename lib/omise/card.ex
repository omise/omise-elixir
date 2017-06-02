defmodule Omise.Card do
  @moduledoc ~S"""
  Provides Card API interfaces.

  https://www.omise.co/cards-api
  """

  defstruct [
    object:              "card",
    id:                  nil,
    livemode:            nil,
    location:            nil,
    country:             nil,
    city:                nil,
    bank:                nil,
    postal_code:         nil,
    financing:           nil,
    last_digits:         nil,
    brand:               nil,
    expiration_month:    nil,
    expiration_year:     nil,
    fingerprint:         nil,
    name:                nil,
    security_code_check: nil,
    created:             nil,
    deleted:             false
  ]

  @type t :: %__MODULE__{
    object:              String.t,
    id:                  String.t,
    livemode:            boolean,
    location:            String.t,
    country:             String.t,
    city:                String.t,
    bank:                String.t,
    postal_code:         String.t,
    financing:           String.t,
    last_digits:         String.t,
    brand:               String.t,
    expiration_month:    integer,
    expiration_year:     integer,
    fingerprint:         String.t,
    name:                String.t,
    security_code_check: boolean,
    created:             String.t,
    deleted:             boolean
  }
end
