defmodule Omise.DisputeTest do
  use ExUnit.Case
  import TestHelper

  setup_all do
    dispute_id = "dspt_test_5089off452g5m5te7xs"

    {:ok, dispute_id: dispute_id}
  end

  test "list all disputes" do
    with_mock_request "disputes-get", fn ->
      {:ok, list} = Omise.Dispute.list

      assert %Omise.List{data: disputes} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each disputes, fn(dispute) ->
        assert %Omise.Dispute{} = dispute
        assert dispute.object == "dispute"
      end
    end
  end

  test "retrieve a dispute", %{dispute_id: dispute_id} do
    with_mock_request "disputes/#{dispute_id}-get", fn ->
      {:ok, dispute} = Omise.Dispute.retrieve(dispute_id)

      assert %Omise.Dispute{} = dispute
      assert dispute.object == "dispute"
      assert dispute.id
      assert is_boolean(dispute.livemode)
      assert dispute.location
      assert dispute.amount
      assert dispute.currency
      assert dispute.status
      refute dispute.message
      assert dispute.charge
      assert dispute.created
    end
  end

  test "update a dispute", %{dispute_id: dispute_id} do
    with_mock_request "disputes/#{dispute_id}-patch", fn ->
      message = "Take me to your best friend house"
      {:ok, dispute} = Omise.Dispute.update(dispute_id, message: message)

      assert %Omise.Dispute{} = dispute
      assert dispute.object == "dispute"
      assert dispute.message == message
    end
  end
end
