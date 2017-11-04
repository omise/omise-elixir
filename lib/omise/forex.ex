defmodule Omise.Forex do
  @moduledoc ~S"""
  Provides Forex API interfaces.

  <https://www.omise.co/forex-api>
  """

  use Omise.HTTPClient, endpoint: "forex"

  defstruct object: "forex",
            from: nil,
            to: nil,
            rate: nil,
            location: nil

  @type t :: %__MODULE__{
          object: String.t(),
          from: String.t(),
          to: String.t(),
          rate: float,
          location: String.t()
        }

  @doc ~S"""
  Retrieve the forex.

  Returns `{:ok, forex}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Forex.retrieve("usd")

      Omise.Forex.retrieve("jpy")

      Omise.Forex.retrieve("sgd")

  """
  @spec retrieve(String.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def retrieve(currency, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{currency}", [], opts)
  end
end
