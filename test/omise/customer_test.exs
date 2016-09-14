defmodule Omise.CustomerTest do
  use ExUnit.Case
  import TestHelper

  setup_all do
    customer_id = "cust_test_52p4kmy02q0i59akn84"

    {:ok, customer_id: customer_id}
  end

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

  test "retrieve a customer", %{customer_id: customer_id} do
    with_mock_request "customers/#{customer_id}-get", fn ->
      {:ok, customer} = Omise.Customer.retrieve(customer_id)

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

  test "update a customer", %{customer_id: customer_id} do
    with_mock_request "customers/#{customer_id}-patch", fn ->
      email = "jane.doe@example.com"
      description = "Jane Doe (id: 30)"
      {:ok, customer} = Omise.Customer.update(
        customer_id,
        email: email,
        description: description
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

  test "destroy a customer", %{customer_id: customer_id} do
    with_mock_request "customers/#{customer_id}-delete", fn ->
      {:ok, customer} = Omise.Customer.destroy(customer_id)

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
end
