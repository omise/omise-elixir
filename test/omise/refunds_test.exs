defmodule Omise.RefundsTest do
  use ExUnit.Case, async: false
  
  setup_all do
    token_params = [
      name: "Edward Elric",
      city: "Bangkok",
      postal_code: 10320,
      number: 4242424242424242,
      security_code: 123,
      expiration_month: 10,
      expiration_year: 2019
    ]
    {:ok, token}  = Omise.Tokens.create(token_params)
    {:ok, charge} = Omise.Charges.create(
      amount: 1000_00,
      currency: "thb",
      card: token.id
    )

    {:ok, charge: charge}
  end

  test "list all refunds", %{charge: charge} do
    {:ok, refunds} = charge |> Omise.Refunds.list

    assert is_list(refunds)
  end

  test "create a refund", %{charge: charge} do
    {:ok, refund} = charge |> Omise.Refunds.create(amount: 500_00)

    assert %Omise.Refund{} = refund
    assert refund.amount == 500_00
  end

  test "failed refund", %{charge: charge} do
    {:error, error} = charge |> Omise.Refunds.create(amount: 10000_00)

    assert error.code == "failed_refund"
  end

  test "retrieve a refund", %{charge: charge} do
    {:ok, created_refund} = charge |> Omise.Refunds.create(amount: 100_00)
    {:ok, retrieved_refund} = charge |> Omise.Refunds.retrieve(created_refund.id)

    assert %Omise.Refund{} = retrieved_refund
    assert retrieved_refund.id != nil
  end
end
