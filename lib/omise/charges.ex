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
    Omise.make_request(:get, @endpoint)
  end

  @doc """
  Retrieve a charge.

  ## Example

  ```
    {:ok, charge} = Omise.Charges.retrieve("chrg_test_4xso2s8ivdej29pqnhz")
  ```

  """
  def retrieve(id) do
    Omise.make_request(:get, "#{@endpoint}/#{id}")
  end

  @doc """
  Create a charge.

  ## Examples

  Charge a card using a token.
  ```
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", card: "tokn_test_4xs9408a642a1htto8z"})
  ```

  Charge a card using a customer.
  ```
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", customer: "cust_test_4xtrb759599jsxlhkrb"})
  ```

  Charge a card using a customer and a card.
  ```
    {:ok, charge} = Omise.Charges.create(%{amount: 10000, currency: "thb", customer: "cust_test_4xtrb759599jsxlhkrb", card: "card_test_4xtsoy2nbfs7ujngyyq"})
  ```

  """
  def create(params) do
    Omise.make_request(:post, @endpoint, params)
  end

  @doc """
  Update a charge.

  ## Example

  ```
    {:ok, charge} = Omise.Charges.update("chrg_test_4xso2s8ivdej29pqnhz", %{description: "New description"})
  ```

  """
  def update(id, params) do
    Omise.make_request(:patch, "#{@endpoint}/#{id}", params)
  end

  @doc """
  Capture a charge.

  ## Example

  ```
    {:ok, charge} = Omise.Charges.capture("chrg_test_4xso2s8ivdej29pqnhz")
  ```

  """
  def capture(id) do
    Omise.make_request(:post, "#{@endpoint}/#{id}/capture", "")
  end
end
