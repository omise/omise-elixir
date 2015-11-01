defmodule Omise.ChargesTest do
  use ExUnit.Case, async: true

  test "list all charges" do
    {:ok, charges} = Omise.Charges.list

    assert is_list charges["data"]
  end

  test "charge a card using a token" do
    token = get_token

    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      card: token
    ])

    assert charge["object"] == "charge"
    assert charge["amount"] == 10000
    assert charge["authorized"] == true
    assert charge["capture"] == true
  end

  test "charge a card using a customer" do
    customer = create_customer

    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      customer: customer["id"]
    ])

    assert charge["object"] == "charge"
    assert charge["amount"] == 10000
    assert charge["authorized"] == true
    assert charge["capture"] == true
  end

  test "charge a card using a customer and a card" do
    customer = create_customer

    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      customer: customer["id"],
      card: customer["default_card"]
    ])

    assert charge["object"] == "charge"
    assert charge["amount"] == 10000
    assert charge["authorized"] == true
    assert charge["capture"] == true
  end

  test "capture a charge" do
    customer = create_customer

    {:ok, uncaptured_charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      customer: customer["id"],
      capture: false
    ])

    {:ok, captured_charge} = Omise.Charges.capture(uncaptured_charge["id"])

    assert uncaptured_charge["captured"] == false
    assert captured_charge["captured"] == true
  end

  test "list all refunds" do
    token = get_token

    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      card: token
    ])

    {:ok, refunds} = Omise.Charges.list_refunds(charge["id"])

    assert is_list refunds["data"]
    assert refunds["object"] == "list"
  end

  test "create a full refund" do
    customer = create_customer

    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      customer: customer["id"]
    ])

    {:ok, refunded_charge} = Omise.Charges.create_refund(charge["id"], [amount: 10000])

    assert refunded_charge["object"] == "refund"
    assert refunded_charge["amount"] == 10000
  end

  test "create a partial refund" do
    customer = create_customer

    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      customer: customer["id"]
    ])

    {:ok, refunded_charge} = Omise.Charges.create_refund(charge["id"], [amount: 5000])

    assert refunded_charge["object"] == "refund"
    assert refunded_charge["amount"] == 5000
  end

  test "failed refund" do
    customer = create_customer

    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      customer: customer["id"]
    ])

    {:error, refunded_charge} = Omise.Charges.create_refund(charge["id"], [amount: 100000])

    assert refunded_charge["object"] == "error"
    assert refunded_charge["code"] == "failed_refund"
  end

  test "retrieve a refund" do
    token = get_token

    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      card: token
    ])

    {:ok, refunded_charge} = Omise.Charges.create_refund(charge["id"], [amount: 10000])
    {:ok, refund} = Omise.Charges.retrieve_refund(charge["id"], refunded_charge["id"])

    assert refund["object"] == "refund"
    assert refund["id"] != nil
  end

  defp create_customer do
    {:ok, customer} = Omise.Customers.create(customer_params)
    customer
  end

  defp customer_params do
    [
      email: "edward@omistry.com",
      description: "Memory is the wonderful thing if you don't have to deal with the past.",
      card: get_token
    ]
  end

  defp get_token do
    {:ok, token} = Omise.Token.create(token_params)
    token["id"]
  end

  defp token_params do
    [
      name: "Edward Elric",
      city: "Bangkok",
      postal_code: 10320,
      number: 4242424242424242,
      security_code: 123,
      expiration_month: 10,
      expiration_year: 2019
    ]
  end
end
