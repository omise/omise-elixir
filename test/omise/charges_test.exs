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

    {:ok, [params: params, customer: customer, card: card]}
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
end
