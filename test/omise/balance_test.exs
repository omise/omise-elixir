defmodule Omise.BalanceTest do
  use ExUnit.Case, async: true

  test "that balance can be retrieved" do
    {:ok, balance} = Omise.Balance.retrieve

    assert balance.object == "balance"
  end
end
