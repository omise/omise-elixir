defmodule Omise.List do
  @moduledoc """
  Omise List Object.

  https://www.omise.co/api-pagination
  """

  defstruct [
    object: "list",
    from:   nil,
    to:     nil,
    offset: nil,
    limit:  nil,
    total:  nil,
    order:  nil,
    data:   []
  ]

  @type t :: %__MODULE__{
    object: String.t,
    from:   String.t,
    to:     String.t,
    offset: Integer.t,
    limit:  Integer.t,
    total:  Integer.t,
    order:  String.t,
    data:   List.t
  }
end
