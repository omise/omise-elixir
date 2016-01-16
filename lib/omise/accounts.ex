defmodule Omise.Accounts do
  @moduledoc """
  Provides Account API interfaces.
  """

  @endpoint "account"

  @doc """
  Retrieve the account.

  Returns `{:ok, account}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, account} = Omise.Accounts.retrieve

  """
  @spec retrieve :: {:ok, Omise.Account.t} | {:error, Omise.Error.t}
  def retrieve do
    Omise.make_request(:get, @endpoint)
  end
end
