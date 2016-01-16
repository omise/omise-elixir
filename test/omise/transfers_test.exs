defmodule Omise.TransfersTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list transfers" do
    with_mock_request "transfers_list", fn ->
      {:ok, transfers} = Omise.Transfers.list

      assert is_list(transfers)
      assert hd(transfers).__struct__ == Omise.Transfer
    end
  end

  test "create a transfer" do
    with_mock_request "transfer_create", fn ->
      {:ok, transfer} = Omise.Transfers.create(amount: 1000_00)

      assert transfer.__struct__ == Omise.Transfer
      assert transfer.id
      assert transfer.location
      assert transfer.recipient
      assert transfer.created
      assert transfer.bank_account
      assert transfer.amount
      assert transfer.currency
      assert transfer.fee
    end
  end
end
