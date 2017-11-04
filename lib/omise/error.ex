defmodule Omise.Error do
  @moduledoc ~S"""
  Omise Error Struct.

  <https://www.omise.co/api-errors>
  """

  defstruct object: "error",
            location: nil,
            code: nil,
            message: nil

  @type t :: %__MODULE__{
          object: String.t(),
          location: String.t(),
          code: String.t(),
          message: String.t()
        }
end
