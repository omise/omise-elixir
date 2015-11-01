defmodule Omise.Charges do
  @moduledoc """
  An API for working with Charges at Omise.
  """

  @endpoint "charges"

  @doc """
  List all charges.

  ## Example

  ```
    {:ok, charges} = Omise.Charges.list
  ```

  """
  def list do
    Omise.get(@endpoint)
  end

  @doc """
  Retrieve a charge.

  ## Example

  ```
    {:ok, charge} = Omise.Charges.retrieve("chrg_test_4xso2s8ivdej29pqnhz")
  ```

  """
  def retrieve(id) do
    Omise.get("#{@endpoint}/#{id}")
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
    Omise.post(@endpoint, params)
  end

  @doc """
  Update a charge.

  ## Example

  ```
    {:ok, charge} = Omise.Charges.update("chrg_test_4xso2s8ivdej29pqnhz", [description: "Hello from the outside."])
  ```

  """
  def update(id, params) do
    Omise.put("#{@endpoint}/#{id}", params)
  end

  @doc """
  Capture a charge.

  ## Example

  ```
    {:ok, charge} = Omise.Charges.capture("chrg_test_4xso2s8ivdej29pqnhz")
  ```

  """
  def capture(id) do
    Omise.post("#{@endpoint}/#{id}/capture")
  end

  @doc """
  List all refunds of a charge.

  ## Example

  ```
    {:ok, refunds} = Omise.Charges.list_refunds("chrg_test_4xso2s8ivdej29pqnhz")
  ```

  """
  def list_refunds(id) do
    Omise.get("#{@endpoint}/#{id}/refunds")
  end

  @doc """
  Create a refund.

  ## Example

  ```
    {:ok, refund} = Omise.Charges.create_refund("chrg_test_4xso2s8ivdej29pqnhz", [amount: 10000])
  ```

  """
  def create_refund(id, params) do
    Omise.post("#{@endpoint}/#{id}/refunds", params)
  end

  @doc """
  Retrieve a refund.

  ## Example

  ```
    {:ok, refund} = Omise.Charges.retrieve_refund("chrg_test_4xso2s8ivdej29pqnhz", "rfnd_test_4zgf1d7jcw5kr123puq")
  ```

  """
  def retrieve_refund(charge_id, refund_id) do
    Omise.get("#{@endpoint}/#{charge_id}/refunds/#{refund_id}")
  end
end
