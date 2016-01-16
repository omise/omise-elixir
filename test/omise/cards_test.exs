defmodule Omise.CardsTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all cards" do
    with_mock_request "cards_list", fn ->
      customer = %Omise.Customer{id: "cust_test_52p4kmy02q0i59akn84"}
      {:ok, cards} =  Omise.Cards.list(customer)

      assert is_list(cards)
      assert hd(cards).__struct__ == Omise.Card
    end
  end

  test "retrieve a card" do
    with_mock_request "card_retrieve", fn ->
      customer = %Omise.Customer{id: "cust_test_52p4kmy02q0i59akn84"}
      {:ok, card} = Omise.Cards.retrieve(customer, "card_test_52p4j8aapq87o18uq04")

      assert card.__struct__ == Omise.Card
      assert card.id
      assert card.location
      assert card.country
      assert card.city
      assert card.postal_code
      assert card.financing
      assert card.bank
      assert card.last_digits
      assert card.brand
      assert card.expiration_month
      assert card.expiration_year
      assert card.fingerprint
      assert card.name
      assert card.security_code_check
      assert card.created
    end
  end
end
