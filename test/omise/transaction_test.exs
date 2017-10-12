defmodule Omise.TransactionTest do
  use Omise.TestCase

  it "can list all transactions", via: "transactions-get" do
    {:ok, list} = Omise.Transaction.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "transaction"))
  end

  it "can retrieve the transaction", via: "transactions/trxn_test_4yq7duwb9jts1vxgqua-get" do
    {:ok, transaction} = Omise.Transaction.retrieve("trxn_test_4yq7duwb9jts1vxgqua")

    assert transaction.id == "trxn_test_4yq7duwb9jts1vxgqua"
  end
end
