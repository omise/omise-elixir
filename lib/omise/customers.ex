defmodule Omise.Customers do
  @moduledoc """
  An API for working with Customers at Omise.
  """

  @endpoint "customers"

  @doc """
  List all customers.

  ## Example

  ```
    {:ok, customers} = Omise.Customers.list
  ```

  """
  def list do
    Omise.process_url(@endpoint)
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  @doc """
  Retrieve a customer.

  ## Example

  ```
    {:ok, customer} = Omise.Customers.retrieve("cust_test_4xtrb759599jsxlhkrb")
  ```

  """
  def retrieve(id) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  @doc """
  Create a customer.

  ## Examples

  Create a customer without attaching a card.
  ```
    {:ok, customer} = Omise.Customers.create(%{email: "teerawat@test.com", description: "La la la"})
  ```

  Create a customer and attach a card.
  ```
    {:ok, customer} = Omise.Customers.create(%{email: "teerawat@test.com", description: "La la la", card: "tokn_test_4xs9408a642a1htto8z"})
  ```

  """
  def create(%{email: email, description: description}) do
    Omise.process_url(@endpoint)
      |> HTTPoison.post({:form, [email: email, description: description]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  def create(%{email: email, description: description, card: card}) do
    Omise.process_url(@endpoint)
      |> HTTPoison.post({:form, [email: email, description: description, card: card]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  @doc """
  Update a customer.

  ## Examples

  Update email and description.
  ```
    {:ok, customer} = Omise.Customers.update("cust_test_4xtrb759599jsxlhkrb", %{email: "teerawat@test.com", description: "La la la"})
  ```

  Attach a card to a customer.
  ```
    {:ok, customer} = Omise.Customers.update("cust_test_4xtrb759599jsxlhkrb", %{card: "tokn_test_4xs9408a642a1htto8z"})
  ```

  """
  def update(id, %{email: email, description: description}) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.patch({:form, [email: email, description: description]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  def update(id, %{card: card}) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.patch({:form, [card: card]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  @doc """
  Destroy a customer.

  ## Example

  ```
    {:ok, customer} = Omise.Customers.destroy("cust_test_4xtrb759599jsxlhkrb")
  ```

  """
  def destroy(id) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.delete(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end
end
