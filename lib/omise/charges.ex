defmodule Omise.Charges do
  @moduledoc """
  An API for working with Charges at Omise.
  """

  @endpoint "charges"

  @doc """
  List all charges.

  ## Examples

  ```
    {:ok, charges} = Omise.Charges.list
  ```

  """
  def list do
    Omise.make_request({:get, @endpoint})
  end

  @doc """
  Retrieve a charge.

  ## Examples

  ```
    {:ok, charge} = Omise.Charges.retrieve("chrg_test_4xso2s8ivdej29pqnhz")
  ```

  """
  def retrieve(id) do
    Omise.make_request({:get, "#{@endpoint}/#{id}"})
  end

  @doc """
  Create a charge.

  ## Examples

  Charge a card using a token.
  ```
    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      card: "tokn_test_51w6fvilnsxalda4cih"
    ])
  ```

  Charge a card using a customer.
  ```
    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      customer: "cust_test_51vtchzn51al0jaa92q"
    ])
  ```

  Charge a card using a customer and a card.
  ```
    {:ok, charge} = Omise.Charges.create([
      amount: 10000,
      currency: "thb",
      customer: "cust_test_51vtchzn51al0jaa92q",
      card: "card_test_51w6jblhhpzmc2g8bcm"
    ])
  ```

  """
  def create(params) do
    Omise.make_request({:post, @endpoint, params})
  end

  @doc """
  Update a charge.

  ## Examples

  ```
    {:ok, charge} = Omise.Charges.update("chrg_test_4xso2s8ivdej29pqnhz", description: "Hello from the outside.")
  ```

  """
  def update(id, params) do
    Omise.make_request({:patch, "#{@endpoint}/#{id}", params})
  end

  @doc """
  Capture a charge.

  ## Examples

  ```
    {:ok, charge} = Omise.Charges.capture("chrg_test_4xso2s8ivdej29pqnhz")
  ```

  """
  def capture(id) do
    Omise.make_request({:post, "#{@endpoint}/#{id}/capture", []})
  end

  @doc """
  List all refunds of a charge.

  ## Examples

  ```
    {:ok, refunds} = Omise.Charges.list_refunds("chrg_test_4xso2s8ivdej29pqnhz")
  ```

  """
  def list_refunds(id) do
    Omise.make_request({:get, "#{@endpoint}/#{id}/refunds"})
  end

  @doc """
  Create a refund.

  ## Examples

  ```
    {:ok, refund} = Omise.Charges.create_refund("chrg_test_4xso2s8ivdej29pqnhz", amount: 10000)
  ```

  """
  def create_refund(id, params) do
    Omise.make_request({:post, "#{@endpoint}/#{id}/refunds", params})
  end

  @doc """
  Retrieve a refund.

  ## Examples

  ```
    {:ok, refund} = Omise.Charges.retrieve_refund("chrg_test_4xso2s8ivdej29pqnhz", "rfnd_test_4zgf1d7jcw5kr123puq")
  ```

  """
  def retrieve_refund(charge_id, refund_id) do
    Omise.make_request({:get, "#{@endpoint}/#{charge_id}/refunds/#{refund_id}"})
  end
end
