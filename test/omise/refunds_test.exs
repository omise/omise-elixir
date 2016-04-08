defmodule Omise.RefundsTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all refunds" do
    with_mock_request "refunds_list", fn ->
      {:ok, refunds} = Omise.Refunds.list("chrg_test_52oo08bwpgnwb95rye8")

      assert is_list(refunds[:data])
    end
  end

  test "retrieve a refund" do
    with_mock_request "refund_retrieve", fn ->
      {:ok, refund} = Omise.Refunds.retrieve("", "rfnd_test_52oo08fnmjlb61n8yda")

      assert refund.id == "rfnd_test_52oo08fnmjlb61n8yda"
      assert refund.charge == "chrg_test_52oo08bwpgnwb95rye8"
      assert refund.location
      assert refund.amount
      assert refund.transaction
      assert refund.created
    end
  end

  test "create a refund" do
    with_mock_request "refund_create", fn ->
      {:ok, refund} = Omise.Refunds.create("chrg_test_52oo08bwpgnwb95rye8", amount: 50_00)

      assert refund.amount == 50_00
    end
  end
end
