defmodule Omise.Forex do
  @moduledoc ~S"""
  Provides Forex API interfaces.

  <https://www.omise.co/forex-api>
  """

  use Omise.HTTPClient, endpoint: "forex"

  @doc ~S"""
  Retrieve the forex.

  Returns `{:ok, forex}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Forex.retrieve("usd")

      Omise.Forex.retrieve("jpy")

      Omise.Forex.retrieve("sgd")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(currency, options \\ []) do
    get("#{@endpoint}/#{currency}", [], options)
  end
end
