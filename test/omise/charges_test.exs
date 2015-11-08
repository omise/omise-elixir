defmodule Omise.ChargesTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, customer} = Omise.Customers.create(
      email: "edward@omistry.com",
      description: "Memory is the wonderful thing if you don't have to deal with the past.",
      card: token.id
    )

    {:ok, customer: customer}
  end

  test "list all charges" do
    {:ok, charges} = Omise.Charges.list

    assert is_list(charges.data)
  end

  test "charge a card using a token" do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      card: token.id
    )

    assert charge.object == "charge"
    assert charge.amount == 10000
    assert charge.authorized == true
    assert charge.capture == true
  end

  test "charge a card using a customer", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      customer: customer.id
    )

    assert charge.object == "charge"
    assert charge.amount == 10000
    assert charge.authorized == true
    assert charge.capture == true
  end

  test "charge a card using a customer and a card", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      customer: customer.id,
      card: customer.default_card
    )

    assert charge.object == "charge"
    assert charge.amount == 10000
    assert charge.authorized == true
    assert charge.capture == true
  end

  test "capture a charge", %{customer: customer} do
    {:ok, uncaptured_charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      customer: customer.id,
      capture: false
    )

    {:ok, captured_charge} = uncaptured_charge.id |> Omise.Charges.capture

    assert uncaptured_charge.captured == false
    assert captured_charge.captured == true
  end

  test "list all refunds" do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      card: token.id
    )

    {:ok, refunds} = charge.id |> Omise.Charges.list_refunds

    assert is_list(refunds.data)
    assert refunds.object == "list"
  end

  test "create a full refund", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      customer: customer.id
    )

    {:ok, refunded_charge} = charge.id |> Omise.Charges.create_refund(amount: 10000)

    assert refunded_charge.object == "refund"
    assert refunded_charge.amount == 10000
  end

  test "create a partial refund", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      customer: customer.id
    )

    {:ok, refunded_charge} = charge.id |> Omise.Charges.create_refund(amount: 5000)

    assert refunded_charge.object == "refund"
    assert refunded_charge.amount == 5000
  end

  test "failed refund", %{customer: customer} do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      customer: customer.id
    )

    {:error, error} = charge.id |> Omise.Charges.create_refund(amount: 100000)

    assert error.code == "failed_refund"
  end

  test "retrieve a refund" do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      card: token.id
    )

    {:ok, refunded_charge} = charge.id |> Omise.Charges.create_refund(amount: 10000)
    {:ok, refund} = charge.id |> Omise.Charges.retrieve_refund(refunded_charge.id)

    assert refund.object == "refund"
    assert refund.id != nil
  end

  defp token do
    {:ok, token} = Omise.Tokens.create(token_params)
    token
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
