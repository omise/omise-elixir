defmodule Omise.ChargesTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all charges" do
    with_mock_request "charges_list", fn ->
      {:ok, charges} =  Omise.Charges.list

      assert is_list(charges)
      assert hd(charges).__struct__ == Omise.Charge
    end
  end

  test "charge a card" do
    with_mock_request "charge_create", fn ->
      {:ok, charge} = Omise.Charges.create(
        amount: 100_00,
        currency: "thb",
        card: "tokn_test_12p4j8aeb6x1v7mk63x"
      )

      assert charge.__struct__ == Omise.Charge
      assert charge.location
      assert charge.authorized
      assert charge.capture
      assert charge.paid
      assert charge.amount == 100_00
      assert charge.transaction == "trxn_test_52p4rhst6ycli7rbxj6"
      assert charge.status == "successful"
    end
  end
end
