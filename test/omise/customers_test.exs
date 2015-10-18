defmodule Omise.CustomersTest do
  use ExUnit.Case, async: true

  test "list all customers" do
    {:ok, customers} = Omise.Customers.list

    assert is_list customers["data"]
  end

  test "retrieve a customer" do
    {:ok, customer} = Omise.Customers.retrieve("cust_test_51n85ryt33q8ukhv4bx")

    assert customer["id"] == "cust_test_51n85ryt33q8ukhv4bx"
  end

  test "create a customer" do
    {:ok, customer} = Omise.Customers.create(%{email: "teerawat@test.com", description: "La la la"})

    assert customer["object"] == "customer"
    assert customer["email"] == "teerawat@test.com"
  end

  test "update a customer" do
    {:ok, customer} = Omise.Customers.update("cust_test_51n85ryt33q8ukhv4bx", %{email: "teerawat@test.com", description: "new description"})

    assert customer["object"] == "customer"
    assert customer["description"] == "new description"
  end

  test "destroy a customer" do
    {:ok, customer} = Omise.Customers.create(%{email: "teerawat@test.com", description: "La la la"})
    {:ok, data} = Omise.Customers.destroy(customer["id"])

    assert data["deleted"] == true
  end
end
