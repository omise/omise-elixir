defmodule Omise.Balances do
  @moduledoc """
  Provides Balance API interfaces.
  """

  @endpoint "balance"

  @doc """
  Retrieve the balance.

  Returns `{:ok, balance}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, balance} = Omise.Balances.retrieve

  """
  @spec retrieve :: {:ok, Omise.Balance.t} | {:error, Omise.Error.t}
  def retrieve do
    Omise.make_request(:get, @endpoint)
  end
end
