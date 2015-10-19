defmodule Omise.Transfers do
  @moduledoc """
  An API for working with Transfers at Omise.
  """

  @endpoint "transfers"

  @doc """
  List all transfers.

  ## Example

  ```
    {:ok, transfers} = Omise.Transfers.list
  ```

  """
  def list do
    Omise.make_request(:get, @endpoint)
  end


  @doc """
  Create a transfer.

  ## Examples

  ```
    {:ok, transfer} = Omise.Transfers.create(%{amount: 100000})

    {:ok, transfer} = Omise.Transfers.create(%{amount: 100000, recipient: "recp_test_4z3wur7amjq2nbg8x44"})
  ```

  """
  def create(params) do
    Omise.make_request(:post, @endpoint, params)
  end
end
