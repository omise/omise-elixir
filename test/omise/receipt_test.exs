defmodule Omise.ReceiptTest do
  use Omise.TestCase

  it "can list all receipts", via: "receipts-get" do
    {:ok, list} = Omise.Receipt.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "receipt"))
  end

  it "can retrieve the receipt", via: "receipts/rcpt_test_12345-get" do
    {:ok, receipt} = Omise.Receipt.retrieve("rcpt_test_12345")

    assert receipt.object == "receipt"
    assert receipt.id == "rcpt_test_12345"
  end
end
