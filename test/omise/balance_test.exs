defmodule Omise.BalanceTest do
  use ExUnit.Case
  import TestHelper

  test "retrieve the balance" do
    with_mock_request "balance-get", fn ->
      {:ok, balance} = Omise.Balance.retrieve

      assert %Omise.Balance{} = balance
      assert balance.object == "balance"
      assert balance.location
      assert balance.available
      assert balance.total
      assert balance.currency
    end
  end
end
