defmodule Omise.CustomerTest do
  use Omise.TestCase

  it "can list all customers", via: "customers-get" do
    {:ok, list} = Omise.Customer.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "customer"))
  end

  it "can retrieve the customer", via: "customers/cust_test_52p4kmy02q0i59akn84-get" do
    {:ok, customer} = Omise.Customer.retrieve("cust_test_52p4kmy02q0i59akn84")

    assert customer.object == "customer"
    assert customer.id == "cust_test_52p4kmy02q0i59akn84"
  end

  it "can create a customer", via: "customers-post" do
    {:ok, customer} = Omise.Customer.create(
      email:       "john.doe@example.com",
      description: "John Doe (id: 30)",
      card:        "tokn_test_4xs9408a642a1htto8z"
    )

    assert customer.object == "customer"
  end

  it "can update the customer", via: "customers/cust_test_52p4kmy02q0i59akn84-patch" do
    {:ok, customer} = Omise.Customer.update("cust_test_52p4kmy02q0i59akn84", [
      email:       "jane.doe@example.com",
      description: "Jane Doe (id: 30)"
    ])

    assert customer.object == "customer"
    assert customer.id == "cust_test_52p4kmy02q0i59akn84"
    assert customer.email == "jane.doe@example.com"
    assert customer.description == "Jane Doe (id: 30)"
  end

  it "can destroy the customer", via: "customers/cust_test_52p4kmy02q0i59akn84-delete" do
    {:ok, customer} = Omise.Customer.destroy("cust_test_52p4kmy02q0i59akn84")

    assert customer.object == "customer"
    assert customer.deleted
  end

  it "can search for customers", via: "search-customer-get" do
    {:ok, search} = Omise.Customer.search(query: "elixir")

    assert search.object == "search"
    assert search.scope == "customer"
    assert search.query == "elixir"
    assert search.filters == %{}
    assert is_list(search.data)
  end

  it "can list all cards", via: "customers/cust_test_52p4kmy02q0i59akn84/cards-get" do
    {:ok, list} = Omise.Customer.list_cards("cust_test_52p4kmy02q0i59akn84")

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "card"))
  end

  it "can retrieve the card", via: "customers/cust_test_52p4kmy02q0i59akn84/cards/card_test_4yq6tuucl9h4erukfl0-get" do
    {:ok, card} = Omise.Customer.retrieve_card("cust_test_52p4kmy02q0i59akn84", "card_test_4yq6tuucl9h4erukfl0")

    assert card.object == "card"
    assert card.id == "card_test_4yq6tuucl9h4erukfl0"
  end

  it "can update the card", via: "customers/cust_test_52p4kmy02q0i59akn84/cards/card_test_4yq6tuucl9h4erukfl0-patch" do
    {:ok, card} = Omise.Customer.update_card("cust_test_52p4kmy02q0i59akn84", "card_test_4yq6tuucl9h4erukfl0", city: "Surin")

    assert card.object == "card"
    assert card.city == "Surin"
  end

  it "can destroy the card", via: "customers/cust_test_52p4kmy02q0i59akn84/cards/card_test_4yq6tuucl9h4erukfl0-delete" do
    {:ok, card} = Omise.Customer.destroy_card("cust_test_52p4kmy02q0i59akn84", "card_test_4yq6tuucl9h4erukfl0")

    assert card.object == "card"
    assert card.deleted
  end

  it "can list all schedules", via: "customers/cust_test_52p4kmy02q0i59akn84/schedules-get" do
    {:ok, list} = Omise.Customer.list_schedules("cust_test_52p4kmy02q0i59akn84")

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "schedule"))
  end
end
