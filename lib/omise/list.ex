defmodule Omise.List do
  @moduledoc """
  Omise List Struct.

  <https://www.omise.co/api-pagination>
  """

  defstruct object: "list",
            from: nil,
            to: nil,
            offset: nil,
            limit: nil,
            total: nil,
            order: nil,
            location: nil,
            data: []

  @type t :: %__MODULE__{
          object: String.t(),
          from: String.t(),
          to: String.t(),
          offset: integer,
          limit: integer,
          total: integer,
          order: String.t(),
          location: String.t(),
          data: list
        }
end
