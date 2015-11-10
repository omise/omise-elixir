defmodule Omise.CustomersTest do
  use ExUnit.Case, async: false

  setup do
    {:ok, customer} = Omise.Customers.create(
      email: "edward@omistry.com",
      description: "Memory is the wonderful thing if you don't have to deal with the past."
    )

    {:ok, customer_id: customer.id}
  end

  test "list all customers" do
    {:ok, customers} = Omise.Customers.list

    assert is_list(customers)
  end

  test "retrieve a customer", %{customer_id: customer_id} do
    {:ok, customer} = Omise.Customers.retrieve(customer_id)

    assert customer.id == customer_id
  end

  test "create a customer" do
    {:ok, customer} = Omise.Customers.create(
      email: "edward@omistry.com",
      description: "Memory is the wonderful thing if you don't have to deal with the past."
    )

    assert %Omise.Customer{} = customer
    assert customer.email == "edward@omistry.com"
  end

  test "update a customer", %{customer_id: customer_id} do
    {:ok, customer} = customer_id |> Omise.Customers.update(email: "ezra@omistry.com", description: "new description")

    assert %Omise.Customer{} = customer
    assert customer.description == "new description"
  end

  test "destroy a customer", %{customer_id: customer_id} do
    {:ok, deleted_customer} = customer_id |> Omise.Customers.destroy

    assert deleted_customer.deleted == true
  end
end
