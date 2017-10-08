defmodule Omise.Account do
  @moduledoc ~S"""
  Provides Account API interfaces.

  <https://www.omise.co/account-api>
  """

  use Omise.HTTPClient, endpoint: "account"

  @doc ~S"""
  Retrieve the account.

  Returns `{:ok, account}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Account.retrieve

      Omise.Account.retrieve(key: "skey_56ia27lqtvg32u7iww8")

  """
  @spec retrieve(Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(options \\ []) do
    get(@endpoint, [], options)
  end
end
