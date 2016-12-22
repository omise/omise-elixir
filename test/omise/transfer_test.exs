defmodule Omise.TransferTest do
  use ExUnit.Case
  import TestHelper

  @transfer_id "trsf_test_4yqacz8t3cbipcj766u"

  test "list all transfers" do
    with_mock_request "transfers-get", fn ->
      {:ok, list} = Omise.Transfer.list

      assert %Omise.List{data: transfers} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each transfers, fn(transfer) ->
        assert %Omise.Transfer{} = transfer
        assert transfer.object == "transfer"
      end
    end
  end

  test "retrieve a transfer" do
    with_mock_request "transfers/#{@transfer_id}-get", fn ->
      {:ok, transfer} = Omise.Transfer.retrieve(@transfer_id)

      assert %Omise.Transfer{} = transfer
      assert transfer.object == "transfer"
      assert transfer.id
      assert is_boolean(transfer.livemode)
      assert transfer.location
      assert transfer.recipient
      assert transfer.created
      assert transfer.bank_account
      assert is_boolean(transfer.sent)
      assert is_boolean(transfer.paid)
      assert transfer.amount
      assert transfer.currency
      assert transfer.fee
      refute transfer.deleted

      bank_account = transfer.bank_account
      assert %Omise.BankAccount{} = bank_account
      assert bank_account.object == "bank_account"
      assert bank_account.brand
      assert bank_account.last_digits
      assert bank_account.name
      assert bank_account.created
    end
  end

  test "create a transfer" do
    with_mock_request "transfers-post", fn ->
      {:ok, transfer} = Omise.Transfer.create(amount: 1000_00)

      assert %Omise.Transfer{} = transfer
      assert transfer.object == "transfer"
      assert transfer.amount == 1000_00
    end
  end

  test "update a transfer" do
    with_mock_request "transfers/#{@transfer_id}-patch", fn ->
      {:ok, transfer} = Omise.Transfer.update(@transfer_id, amount: 2000_00)

      assert %Omise.Transfer{} = transfer
      assert transfer.object == "transfer"
      assert transfer.amount == 2000_00
    end
  end

  test "destroy a transfer" do
    with_mock_request "transfers/#{@transfer_id}-delete", fn ->
      {:ok, transfer} = Omise.Transfer.destroy(@transfer_id)

      assert %Omise.Transfer{} = transfer
      assert transfer.object == "transfer"
      assert transfer.id == @transfer_id
      assert transfer.deleted
    end
  end
end
