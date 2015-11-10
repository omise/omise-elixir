defmodule Omise.TransfersTest do
  use ExUnit.Case, async: false

  test "list transfers" do
    {:ok, transfers} = Omise.Transfers.list

    assert is_list(transfers)
  end

  test "create a transfer" do
    {:ok, transfer} = Omise.Transfers.create(amount: 10000)

    assert %Omise.Transfer{} = transfer
    assert transfer.amount == 10000
  end
end
