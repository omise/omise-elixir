defmodule Omise.BalancesTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "retrieve the balance" do
    with_mock_request "balance_retrieve", fn ->
      {:ok, balance} = Omise.Balances.retrieve

      assert balance.location
      assert balance.available
      assert balance.total
      assert balance.currency
    end
  end
end
