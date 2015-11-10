defmodule Omise.CardsTest do
  use ExUnit.Case, async: false

  setup_all do
    token_params = [
      name: "Adele",
      city: "London",
      postal_code: 55555,
      number: 4242424242424242,
      security_code: 123,
      expiration_month: 10,
      expiration_year: 2019
    ]
    {:ok, token}  = Omise.Tokens.create(token_params)
    {:ok, customer} = Omise.Customers.create(
      email: "adele@omistry.com",
      description: "Don't underestimate the things that i will do.",
      card: token.id
    )

    {:ok, customer: customer}
  end

  test "list all cards", %{customer: customer} do
    {:ok, cards} = customer |> Omise.Cards.list

    assert is_list(cards)
    assert %Omise.Card{} = List.first(cards)
  end
end
