defmodule Omise.RefundTest do
  use ExUnit.Case
  import TestHelper

  @charge_id "chrg_test_4yq7duw15p9hdrjp8oq"
  @refund_id "rfnd_test_4yqmv79ahghsiz23y3c"

  test "list all refunds" do
    with_mock_request "charges/#{@charge_id}/refunds-get", fn ->
      {:ok, list} = Omise.Refund.list(@charge_id)

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

  test "retrieve a refund" do
    with_mock_request "charges/#{@charge_id}/refunds/#{@refund_id}-get", fn ->
      {:ok, refund} = Omise.Refund.retrieve(@charge_id, @refund_id)

      assert %Omise.Refund{} = refund
      assert refund.object == "refund"
      assert refund.id
      assert refund.location
      assert refund.amount
      assert refund.currency
      assert is_boolean(refund.voided)
      assert refund.charge
      assert refund.transaction
      assert refund.created
    end
  end

  test "create a refund" do
    with_mock_request "charges/#{@charge_id}/refunds-post", fn ->
      {:ok, refund} = Omise.Refund.create(@charge_id, amount: 100_00)

      assert %Omise.Refund{} = refund
      assert refund.object == "refund"
      assert refund.amount == 100_00
    end
  end
end
