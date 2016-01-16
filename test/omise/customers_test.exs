defmodule Omise.CustomersTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all customers" do
    with_mock_request "customers_list", fn ->
      {:ok, customers} =  Omise.Customers.list

      assert is_list(customers)
      assert hd(customers).__struct__ == Omise.Customer
    end
  end

  test "retrieve a customer" do
    with_mock_request "customer_retrieve", fn ->
      {:ok, customer} =  Omise.Customers.retrieve("cust_test_52om9f276dyzfkhmjch")

      assert customer.__struct__ == Omise.Customer
      assert customer.id == "cust_test_52om9f276dyzfkhmjch"
      assert customer.location
      assert customer.default_card
      assert customer.email
      assert customer.description
      assert customer.created
      assert customer.cards
    end
  end

  test "create a customer" do
    with_mock_request "customer_create", fn ->
      {:ok, customer} =  Omise.Customers.create(
        email: "jibanyan@email.com",
        description: "Meowwww"
      )

      assert customer.__struct__ == Omise.Customer
      assert customer.email == "jibanyan@email.com"
      assert customer.description == "Meowwww"
    end
  end
end
