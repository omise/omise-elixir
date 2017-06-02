defmodule Omise.CustomerTest do
  use ExUnit.Case
  import TestHelper

  @customer_id "cust_test_52p4kmy02q0i59akn84"
  @card_id     "card_test_4yq6tuucl9h4erukfl0"

  test "list all customers" do
    with_mock_request "customers-get", fn ->
      {:ok, list} = Omise.Customer.list

      assert %Omise.List{data: customers} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each customers, fn(customer) ->
        assert %Omise.Customer{} = customer
        assert customer.object == "customer"
      end
    end
  end

  test "retrieve a customer" do
    with_mock_request "customers/#{@customer_id}-get", fn ->
      {:ok, customer} = Omise.Customer.retrieve(@customer_id)

      assert %Omise.Customer{} = customer
      assert customer.object == "customer"
      assert customer.id
      assert is_boolean(customer.livemode)
      assert customer.location
      assert customer.default_card
      assert customer.email
      assert customer.description
      assert customer.created
      assert customer.cards
      refute customer.deleted

      assert %Omise.List{} = customer.cards
    end
  end

  test "create a customer" do
    with_mock_request "customers-post", fn ->
      email = "john.doe@example.com"
      description = "John Doe (id: 30)"
      {:ok, customer} = Omise.Customer.create(
        email: email,
        description: description,
        card: "tokn_test_4xs9408a642a1htto8z"
      )

      assert %Omise.Customer{} = customer
      assert customer.object == "customer"
      assert customer.id
      assert is_boolean(customer.livemode)
      assert customer.location
      assert customer.default_card
      assert customer.email == email
      assert customer.description == description
      assert customer.created
      assert customer.cards
      refute customer.deleted

      assert %Omise.List{} = customer.cards
    end
  end

  test "update a customer" do
    with_mock_request "customers/#{@customer_id}-patch", fn ->
      email       = "jane.doe@example.com"
      description = "Jane Doe (id: 30)"

      {:ok, customer} = Omise.Customer.update(@customer_id, [
        email:       email,
        description: description,
      ])

      assert %Omise.Customer{} = customer
      assert customer.object == "customer"
      assert customer.id
      assert is_boolean(customer.livemode)
      assert customer.location
      assert customer.default_card
      assert customer.email == email
      assert customer.description == description
      assert customer.created
      assert customer.cards
      refute customer.deleted

      assert %Omise.List{} = customer.cards
    end
  end

  test "destroy a customer" do
    with_mock_request "customers/#{@customer_id}-delete", fn ->
      {:ok, customer} = Omise.Customer.destroy(@customer_id)

      assert %Omise.Customer{} = customer
      assert customer.object == "customer"
      assert customer.deleted
    end
  end

  test "search customers" do
    with_mock_request "search-customer-get", fn ->
      {:ok, search_data} = Omise.Customer.search(query: "elixir")

      assert %Omise.Search{data: data} = search_data
      assert search_data.object == "search"
      assert search_data.scope == "customer"
      assert search_data.query == "elixir"
      assert search_data.filters == %{}
      assert search_data.page == 1
      assert search_data.total_pages == 1
      assert search_data.total == 2
      assert is_list(data)
      Enum.each data, fn(customer) ->
        assert Regex.match?(~r/elixir/i, customer.description)
      end
    end
  end

  test "list all cards" do
    with_mock_request "customers/#{@customer_id}/cards", fn ->
      {:ok, list} = Omise.Customer.list_cards(@customer_id)

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
      {:ok, card} = Omise.Customer.retrieve_card(@customer_id, @card_id)

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
      {:error, error} = Omise.Customer.retrieve_card(@customer_id, "404")

      assert %Omise.Error{} = error
      assert error.object == "error"
      assert error.code == "not_found"
      assert error.location
      assert error.message
    end
  end

  test "update a card"  do
    with_mock_request "customers/#{@customer_id}/cards/#{@card_id}-patch", fn ->
      {:ok, card} = Omise.Customer.update_card(@customer_id, @card_id, city: "Surin")

      assert %Omise.Card{} = card
      assert card.id == @card_id
      assert card.city == "Surin"
      refute card.deleted
    end
  end

  test "destroy a card"  do
    with_mock_request "customers/#{@customer_id}/cards/#{@card_id}-delete", fn ->
      {:ok, card} = Omise.Customer.destroy_card(@customer_id, @card_id)

      assert %Omise.Card{} = card
      assert card.id == @card_id
      assert card.deleted
    end
  end
end
