defmodule Omise.TransfersTest do
  use ExUnit.Case, async: true

  test "list transfers" do
    {:ok, transfers} = Omise.Transfers.list

    assert is_list transfers["data"]
  end

  test "create a transfer" do
    {:ok, transfer} = Omise.Transfers.create(amount: 10000)

    assert transfer["object"] == "transfer"
    assert transfer["amount"] == 10000
  end
end
