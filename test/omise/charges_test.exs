defmodule Omise.ChargesTest do
  use ExUnit.Case, async: true

  setup do
    params = %{
      name: "JOHN DOE",
      city: "Bangkok",
      postal_code: 10320,
      number: 4242424242424242,
      security_code: 123,
      expiration_month: 10,
      expiration_year: 2019
    }
    customer = "cust_test_51n85ryt33q8ukhv4bx"
    card = "card_test_51n89x91zsbeo3wr0rd"
    charge = "chrg_test_51nkcyfkdwsqkhfgg8v"
    refund = "rfnd_test_51qc0xlfedppxv6m2a1"

    {:ok, [params: params, customer: customer, card: card, charge: charge, refund: refund]}
  end

  test "list all charges" do
    {:ok, charges} = Omise.Charges.list

    assert is_list charges["data"]
  end

  test "charge a card using a token", %{params: params} do
    # Create a token
    {:ok, token} = Omise.Token.create(params)

    # Create a charge
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", card: token["id"]})

    assert charge["object"] == "charge"
    assert charge["amount"] == 10000
    assert charge["authorized"] == true
    assert charge["capture"] == true
  end

  test "charge a card using a customer", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", customer: customer})

    assert charge["object"] == "charge"
    assert charge["amount"] == 10000
    assert charge["authorized"] == true
    assert charge["capture"] == true
  end

  test "charge a card using a customer and a card", %{customer: customer, card: card} do
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", customer: customer, card: card})

    assert charge["object"] == "charge"
    assert charge["amount"] == 10000
    assert charge["authorized"] == true
    assert charge["capture"] == true
  end

  test "capture a charge", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", customer: customer, capture: false})
    {:ok, captured_charge} = Omise.Charges.capture(charge["id"])

    assert charge["captured"] == false
    assert captured_charge["captured"] == true
  end

  test "list all refunds", %{charge: charge} do
    {:ok, refunds} = Omise.Charges.list_refunds(charge)

    assert is_list refunds["data"]
    assert refunds["object"] == "list"
  end

  test "create a full refund", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", customer: customer})
    {:ok, refunded_charge} = Omise.Charges.create_refund(charge["id"], %{amount: 10000})

    assert refunded_charge["object"] == "refund"
    assert refunded_charge["amount"] == 10000
  end

  test "create a partial refund", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", customer: customer})
    {:ok, refunded_charge} = Omise.Charges.create_refund(charge["id"], %{amount: 5000})

    assert refunded_charge["object"] == "refund"
    assert refunded_charge["amount"] == 5000
  end

  test "failed refund", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", customer: customer})
    {:error, refunded_charge} = Omise.Charges.create_refund(charge["id"], %{amount: 100000})

    assert refunded_charge["object"] == "error"
    assert refunded_charge["code"] == "failed_refund"
  end

  test "retrieve a refund", %{charge: charge, refund: refund} do
    {:ok, refund} = Omise.Charges.retrieve_refund(charge, refund)

    assert refund["object"] == "refund"
    assert refund["id"] != nil
  end
end
