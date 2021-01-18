defmodule Omise.Barcode do
  @moduledoc ~S"""
  Provides Barcode API interfaces.
  """

  defstruct object: "barcode",
            type: nil,
            image: %Omise.Document{}

  @type t :: %__MODULE__{
          object: String.t(),
          type: String.t(),
          image: Omise.Document.t()
        }
end
