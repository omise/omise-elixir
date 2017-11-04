defmodule Omise.Document do
  @moduledoc ~S"""
  Provides Document API interfaces.

  <https://www.omise.co/documents-api>
  """

  defstruct object: "document",
            id: nil,
            livemode: nil,
            location: nil,
            filename: nil,
            deleted: false

  @type t :: %__MODULE__{
          object: String.t(),
          id: String.t(),
          livemode: boolean,
          location: String.t(),
          filename: String.t(),
          deleted: boolean
        }
end
