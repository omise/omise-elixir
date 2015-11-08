defmodule Omise.Customers do
  @moduledoc """
  An API for working with Customers at Omise.
  """

  @endpoint "customers"

  @doc """
  List all customers.

  ## Examples

  ```
    {:ok, customers} = Omise.Customers.list
  ```

  """
  def list do
    Omise.make_request({:get, @endpoint})
  end

  @doc """
  Retrieve a customer.

  ## Examples

  ```
    {:ok, customer} = Omise.Customers.retrieve("cust_test_4xtrb759599jsxlhkrb")
  ```

  """
  def retrieve(id) do
    Omise.make_request({:get, "#{@endpoint}/#{id}"})
  end

  @doc """
  Create a customer.

  ## Examples

  Create a customer without attaching a card.
  ```
    {:ok, customer} = Omise.Customers.create([
      email: "edward@omistry.com",
      description: "Shut up, thief."
    ])
  ```

  Create a customer and attach a card.
  ```
    {:ok, customer} = Omise.Customers.create([
      email: "edward@omistry.com",
      description: "Shut up, thief.",
      card: "tokn_test_51yer81s9aqqyktdoeh"
    ])
  ```

  """
  def create(params) do
    Omise.make_request({:post, @endpoint, params})
  end

  @doc """
  Update a customer.

  ## Examples

  Update email and description.
  ```
    {:ok, customer} = Omise.Customers.update("cust_test_51yerhn3ghztgv31n4p", email: "edward@omistry.com", description: "Hello, it's me.")
  ```

  Attach a card to a customer.
  ```
    {:ok, customer} = Omise.Customers.update("cust_test_4xtrb759599jsxlhkrb", card: "tokn_test_4xs9408a642a1htto8z")
  ```

  """
  def update(id, params) do
    Omise.make_request({:patch, "#{@endpoint}/#{id}", params})
  end

  @doc """
  Destroy a customer.

  ## Examples

  ```
    {:ok, customer} = Omise.Customers.destroy("cust_test_4xtrb759599jsxlhkrb")
  ```

  """
  def destroy(id) do
    Omise.make_request({:delete, "#{@endpoint}/#{id}"})
  end
end
