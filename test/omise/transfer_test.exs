defmodule Omise.TransferTest do
  use Omise.TestCase

  it "can list all transfers", via: "transfers-get" do
    {:ok, list} = Omise.Transfer.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "transfer"))
  end

  it "can retrieve the transfer", via: "transfers/trsf_test_4yqacz8t3cbipcj766u-get" do
    {:ok, transfer} = Omise.Transfer.retrieve("trsf_test_4yqacz8t3cbipcj766u")

    assert transfer.object == "transfer"
    assert transfer.id == "trsf_test_4yqacz8t3cbipcj766u"
    assert transfer.bank_account.object == "bank_account"
  end

  it "can create a transfer", via: "transfers-post" do
    {:ok, transfer} = Omise.Transfer.create(amount: 100000)

    assert transfer.object == "transfer"
    assert transfer.amount == 100000
  end

  it "can update the transfer", via: "transfers/trsf_test_4yqacz8t3cbipcj766u-patch" do
    {:ok, transfer} = Omise.Transfer.update("trsf_test_4yqacz8t3cbipcj766u", amount: 200000)

    assert transfer.object == "transfer"
    assert transfer.amount == 200000
  end

  it "can destroy a transfer", via: "transfers/trsf_test_4yqacz8t3cbipcj766u-delete" do
    {:ok, transfer} = Omise.Transfer.destroy("trsf_test_4yqacz8t3cbipcj766u", amount: 200000)

    assert transfer.object == "transfer"
    assert transfer.deleted
  end

  it "can list all schedules", via: "transfers/schedules-get" do
    {:ok, list} = Omise.Transfer.list_schedules

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "schedule"))
  end
end
