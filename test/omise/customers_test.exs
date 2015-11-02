defmodule Omise.CustomersTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, customer} = Omise.Customers.create(
      [email: "edward@omistry.com",
      description: "Memory is the wonderful thing if you don't have to deal with the past."
    ])

    {:ok, [customer_id: customer["id"]]}
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
    {:ok, customer} = Omise.Customers.create([
      email: "edward@omistry.com",
      description: "Memory is the wonderful thing if you don't have to deal with the past."
    ])

    assert customer["object"] == "customer"
    assert customer["email"] == "edward@omistry.com"
  end

  test "update a customer", %{customer_id: customer_id} do
    {:ok, customer} = Omise.Customers.update(customer_id, [email: "ezra@omistry.com", description: "new description"])

    assert customer["object"] == "customer"
    assert customer["description"] == "new description"
  end

  test "destroy a customer", %{customer_id: customer_id} do
    {:ok, data} = Omise.Customers.destroy(customer_id)

    assert data["deleted"] == true
  end
end
