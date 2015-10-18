defmodule Omise.Balance do
  @moduledoc """
  An API for working with Balance at Omise.
  """

  @endpoint "balance"

  @doc """
  Retrieve the balance.

  ## Example

  ```
    {:ok, balance} = Omise.Balance.retrieve
  ```

  """
  def retrieve do
    Omise.make_request(:get, @endpoint)
  end
end
