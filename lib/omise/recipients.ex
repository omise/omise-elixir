defmodule Omise.Recipients do
  @moduledoc """
  An API for working with Recipients at Omise.
  """

  @endpoint "recipients"

  @doc """
  List all recipients.

  ## Example

  ```
    {:ok, recipients} = Omise.Recipients.list
  ```

  """
  def list do
    Omise.get(@endpoint)
  end

  @doc """
  Retrieve a recipient.

  ## Example

  ```
    {:ok, recipient} = Omise.Recipients.retrieve("recp_test_4z6p7e0m4k40txecj5o")
  ```

  """
  def retrieve(id) do
    Omise.get("#{@endpoint}/#{id}")
  end

  @doc """
  Create a recipient.

  ## Example

  ```
    params = [
      name: "Edward Elric",
      email: "edward@omistry.com",
      description: "Go away!",
      type: "individual",
      bank_account: [
        brand: "bbl",
        number: "acc12345",
        name: "Edward Elric"
      ]
    ]

    {:ok, recipient} = Omise.Recipients.create(params)
  ```

  """
  def create(params) do
    Omise.post(@endpoint, Omise.Util.transform_recipient_params(params))
  end

  @doc """
  Destroy a recipient.

  ## Example

  ```
    {:ok, recipient} = Omise.Recipients.destroy("recp_test_4z6p7e0m4k40txecj5o")
  ```

  """
  def destroy(id) do
    Omise.delete("#{@endpoint}/#{id}")
  end
end
