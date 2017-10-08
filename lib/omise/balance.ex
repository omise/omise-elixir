defmodule Omise.Balance do
  @moduledoc ~S"""
  Provides Balance API interfaces.

  <https://www.omise.co/balance-api>
  """

  use Omise.HTTPClient, endpoint: "balance"

  @doc ~S"""
  Retrieve the balance.

  Returns `{:ok, balance}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Balance.retrieve

      Omise.Balance.retrieve(key: "skey_56ia27lqtvg32u7iww8")

  """
  @spec retrieve(Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(options \\ []) do
    get(@endpoint, [], options)
  end
end
