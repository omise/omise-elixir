defmodule Omise.ScannableCode do
  @moduledoc ~S"""
  Provides ScannableCode API interfaces.
  """

  defstruct object: "barcode",
            type: "barcode",
            image: %Omise.Document{}

  @type t :: %__MODULE__{
          object: String.t(),
          type: String.t(),
          image: Omise.Document.t()
        }
end
