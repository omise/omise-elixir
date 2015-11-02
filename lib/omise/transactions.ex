defmodule Omise.Transactions do
  @moduledoc """
  An API for working with Transaction at Omise.
  """

  @endpoint "transactions"

  @doc """
  List all transactions.

  ## Examples

  ```
    {:ok, transactions} = Omise.Transactions.list
  ```

  """
  def list do
    Omise.make_request({:get, @endpoint})
  end

  @doc """
  Retrieve a transaction.

  ## Examples

  ```
    {:ok, transaction} = Omise.Transactions.retrieve("trxn_test_51yg3xs2yggzsfbai3e")
  ```

  """
  def retrieve(id) do
    Omise.make_request({:get, "#{@endpoint}/#{id}"})
  end
end
