defmodule Omise.ChargesTest do
  use ExUnit.Case, async: false

  setup_all do
    {:ok, customer} = Omise.Customers.create(
      email: "edward@omistry.com",
      description: "Memory is the wonderful thing if you don't have to deal with the past.",
      card: token.id
    )

    {:ok, customer: customer}
  end

  test "list all charges" do
    {:ok, charges} = Omise.Charges.list

    assert is_list(charges)
  end

  test "charge a card using a token" do
    {:ok, charge} = Omise.Charges.create(
      amount: 10000,
      currency: "thb",
      card: token.id
    )

    assert %Omise.Charge{} = charge
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

    assert %Omise.Charge{} = charge
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

    assert %Omise.Charge{} = charge
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

    try do
      assert uncaptured_charge.captured == false
      assert captured_charge.captured == true
    rescue
      _ ->
        assert uncaptured_charge.paid == false
        assert captured_charge.paid == true
    end
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
