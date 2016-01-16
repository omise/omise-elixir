defmodule Omise.DisputesTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all disputes" do
    with_mock_request "disputes_list", fn ->
      {:ok, disputes} = Omise.Disputes.list

      assert is_list(disputes)
      assert hd(disputes).__struct__ == Omise.Dispute
    end
  end

  test "retrieve a dispute" do
    with_mock_request "dispute_retrieve", fn ->
      {:ok, dispute} = Omise.Disputes.retrieve("dspt_test_52pdgtq055yw92v7zsi")

      assert dispute.__struct__ == Omise.Dispute
      assert dispute.id
      assert dispute.location
      assert dispute.amount
      assert dispute.currency
      assert dispute.status
      assert dispute.message
      assert dispute.charge
      assert dispute.created
    end
  end

  test "update a dispute" do
    with_mock_request "dispute_update", fn ->
      {:ok, dispute} = Omise.Disputes.update("dspt_test_52pdgtq055yw92v7zsi",
        message: "This is a new message"
      )

      assert dispute.__struct__ == Omise.Dispute
      assert dispute.id == "dspt_test_52pdkesu32m4l5zkhtb"
      assert dispute.message == "This is a new message"
      assert dispute.status == "pending"
    end
  end
end
