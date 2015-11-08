defmodule Omise.Account do
  @moduledoc """
  An API for working with Account at Omise.
  """

  @endpoint "account"

  @doc """
  Retrieve the account.

  ## Examples

  ```
    {:ok, account} = Omise.Account.retrieve
  ```

  """
  def retrieve do
    Omise.make_request({:get, @endpoint})
  end
end
