defmodule Omise.TransactionsTest do
  use ExUnit.Case, async: false

  test "list all transactions" do
    {:ok, transactions} = Omise.Transactions.list

    assert is_list(transactions)
  end
end
