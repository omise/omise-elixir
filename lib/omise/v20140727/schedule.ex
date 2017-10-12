defmodule Omise.V20140727.Schedule do
  @moduledoc false

  defstruct [
    object:                "schedule",
    id:                    nil,
    livemode:              nil,
    location:              nil,
    status:                nil,
    every:                 nil,
    period:                nil,
    on:                    nil,
    in_words:              nil,
    start_date:            nil,
    end_date:              nil,
    charge:                %{},
    transfer:              %{},
    occurrences:           nil,
    next_occurrence_dates: nil,
    created:               nil,
  ]

  @type t :: %__MODULE__{
    object:                String.t,
    id:                    String.t,
    livemode:              boolean,
    location:              String.t,
    status:                String.t,
    every:                 integer,
    period:                String.t,
    on:                    map,
    in_words:              String.t,
    start_date:            String.t,
    end_date:              String.t,
    charge:                map,
    transfer:              map,
    occurrences:           list,
    next_occurrence_dates: list,
    created:               String.t,
  }

  defimpl Poison.Decoder do
    def decode(%{occurrences: occurrences} = schedule, options) do
      decoded_occurrences = Omise.Decoder.decode(occurrences, options)

      %{schedule | occurrences: decoded_occurrences}
    end
  end
end
