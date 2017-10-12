defmodule Omise.Occurrence do
  @moduledoc ~S"""
  Provides Occurrence API interfaces.

  <https://www.omise.co/occurrences-api>
  """

  use Omise.HTTPClient, endpoint: "occurrences"

  @doc ~S"""
  Retrieve an occurrence.

  ## Examples

      Omise.Occurrence.retrieve("occu_test_584yqgivyi2p1g828pl")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(id, options \\ []) do
    get("#{@endpoint}/#{id}", [], options)
  end
end
