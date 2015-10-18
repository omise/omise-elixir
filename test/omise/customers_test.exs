defmodule Omise.CustomersTest do
  use ExUnit.Case, async: true

  setup do
    customer_id = "cust_test_51n85ryt33q8ukhv4bx"

    {:ok, [customer_id: customer_id]}
  end

  test "list all customers" do
    {:ok, customers} = Omise.Customers.list

    assert is_list customers["data"]
  end

  test "retrieve a customer", %{customer_id: customer_id} do
    {:ok, customer} = Omise.Customers.retrieve(customer_id)

    assert customer["id"] == customer_id
  end

  test "create a customer" do
    {:ok, customer} = Omise.Customers.create(%{email: "teerawat@test.com", description: "La la la"})

    assert customer["object"] == "customer"
    assert customer["email"] == "teerawat@test.com"
  end

  test "update a customer", %{customer_id: customer_id} do
    {:ok, customer} = Omise.Customers.update(customer_id, %{email: "teerawat@test.com", description: "new description"})

    assert customer["object"] == "customer"
    assert customer["description"] == "new description"
  end

  test "destroy a customer" do
    {:ok, customer} = Omise.Customers.create(%{email: "teerawat@test.com", description: "La la la"})
    {:ok, data} = Omise.Customers.destroy(customer["id"])

    assert data["deleted"] == true
  end
end
