defmodule Omise.CardTest do
  use ExUnit.Case
  import TestHelper

  @customer_id "cust_test_52p4kmy02q0i59akn84"
  @card_id     "card_test_4yq6tuucl9h4erukfl0"

  test "list all cards" do
    with_mock_request "customers/#{@customer_id}/cards", fn ->
      {:ok, list} = Omise.Card.list(@customer_id)

      assert %Omise.List{data: cards} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each cards, fn(card) ->
        assert %Omise.Card{} = card
        assert card.object == "card"
      end
    end
  end

  test "retrieve a card" do
    with_mock_request "customers/#{@customer_id}/cards/#{@card_id}-get", fn ->
      {:ok, card} = Omise.Card.retrieve(@customer_id, @card_id)

      assert %Omise.Card{} = card
      assert card.object == "card"
      assert card.id
      assert is_boolean(card.livemode)
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
      refute card.deleted
    end
  end

  test "retrieve a non existing card" do
    with_mock_request "customers/#{@customer_id}/cards/404-get", fn ->
      {:error, error} = Omise.Card.retrieve(@customer_id, "404")

      assert %Omise.Error{} = error
      assert error.object == "error"
      assert error.code == "not_found"
      assert error.location
      assert error.message
    end
  end

  test "update a card"  do
    with_mock_request "customers/#{@customer_id}/cards/#{@card_id}-patch", fn ->
      {:ok, card} = Omise.Card.update(@customer_id, @card_id, city: "Surin")

      assert %Omise.Card{} = card
      assert card.id == @card_id
      assert card.city == "Surin"
      refute card.deleted
    end
  end

  test "destroy a card"  do
    with_mock_request "customers/#{@customer_id}/cards/#{@card_id}-delete", fn ->
      {:ok, card} = Omise.Card.destroy(@customer_id, @card_id)

      assert %Omise.Card{} = card
      assert card.id == @card_id
      assert card.deleted
    end
  end
end
