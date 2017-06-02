defmodule Omise.RefundTest do
  use ExUnit.Case
  import TestHelper

  test "list all refunds" do
    with_mock_request "refunds-get", fn ->
      {:ok, list} = Omise.Refund.list

      assert %Omise.List{data: refunds} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each refunds, fn(refund) ->
        assert %Omise.Refund{} = refund
        assert refund.object == "refund"
      end
    end
  end
end
