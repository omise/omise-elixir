defmodule Omise.RefundsTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all refunds" do
    with_mock_request "refunds_list", fn ->
      charge = %Omise.Charge{id: "chrg_test_52oo08bwpgnwb95rye8"}
      {:ok, refunds} = Omise.Refunds.list(charge)

      assert is_list(refunds)
      assert hd(refunds).__struct__ == Omise.Refund
    end
  end

  test "retrieve a refund" do
    with_mock_request "refund_retrieve", fn ->
      charge = %Omise.Charge{id: "chrg_test_52oo08bwpgnwb95rye8"}
      {:ok, refund} = Omise.Refunds.retrieve(charge, "rfnd_test_52oo08fnmjlb61n8yda")

      assert refund.__struct__ == Omise.Refund
      assert refund.id == "rfnd_test_52oo08fnmjlb61n8yda"
      assert refund.charge == charge.id
      assert refund.location
      assert refund.amount
      assert refund.transaction
      assert refund.created
    end
  end

  test "create a refund" do
    with_mock_request "refund_create", fn ->
      charge = %Omise.Charge{id: "chrg_test_52oo08bwpgnwb95rye8"}
      {:ok, refund} = Omise.Refunds.create(charge, amount: 50_00)

      assert refund.__struct__ == Omise.Refund
      assert refund.amount == 50_00
    end
  end
end
