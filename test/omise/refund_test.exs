defmodule Omise.RefundTest do
  use Omise.TestCase

  it "can list all refunds", via: "refunds-get" do
    {:ok, list} = Omise.Refund.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "refund"))
  end
end
