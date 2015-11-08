defmodule Omise.TransactionsTest do
  use ExUnit.Case, async: true

  test "list all transactions" do
    {:ok, transactions} = Omise.Transactions.list

    assert is_list(transactions.data)
  end
end
