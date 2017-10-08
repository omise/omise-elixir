defmodule Omise.V20140727.Occurrence do
  @moduledoc false

  defstruct [
    object:        "occurrence",
    id:            nil,
    livemode:      nil,
    location:      nil,
    schedule:      nil,
    schedule_date: nil,
    retry_date:    nil,
    processed_at:  nil,
    status:        nil,
    message:       nil,
    result:        nil,
    created:       nil,
  ]

  @type t :: %__MODULE__{
    object:        String.t,
    id:            String.t,
    livemode:      boolean,
    location:      String.t,
    schedule:      String.t,
    schedule_date: String.t,
    retry_date:    String.t,
    processed_at:  String.t,
    status:        String.t,
    message:       String.t,
    result:        String.t,
    created:       String.t,
  }
end
