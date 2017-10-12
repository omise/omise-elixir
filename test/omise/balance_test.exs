defmodule Omise.BalanceTest do
  use Omise.TestCase

  it "can retrieve the balance", via: "balance-get" do
    {:ok, balance} = Omise.Balance.retrieve

    assert balance.object == "balance"
  end
end
