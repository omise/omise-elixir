defmodule Omise.BalancesTest do
  use ExUnit.Case, async: false

  test "retrieve the balance" do
    {:ok, balance} = Omise.Balances.retrieve

    assert %Omise.Balance{} = balance
  end
end
