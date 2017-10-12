defmodule Omise.V20140727.Search do
  @moduledoc false

  defstruct [
    object:      "search",
    location:    nil,
    order:       nil,
    scope:       nil,
    query:       nil,
    filters:     nil,
    page:        nil,
    per_page:    nil,
    total_pages: nil,
    total:       nil,
    data:        []
  ]

  @type t :: %__MODULE__{
    object:      String.t,
    location:    String.t,
    order:       String.t,
    scope:       String.t,
    query:       String.t,
    filters:     map,
    page:        integer,
    per_page:    integer,
    total_pages: integer,
    total:       integer,
    data:        list
  }

  defimpl Poison.Decoder do
    def decode(%{data: data} = search, options) do
      decoded_data = Omise.Decoder.decode(data, options)

      %{search | data: decoded_data}
    end
  end
end
