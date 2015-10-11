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
    Omise.process_url(@endpoint)
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  @doc """
  Retrieve a recipient.

  ## Example

  ```
    {:ok, recipient} = Omise.Recipients.retrieve("recp_test_4z6p7e0m4k40txecj5o")
  ```

  """
  def retrieve(id) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  @doc """
  Create a recipient.

  ## Example

  ```
    params = %{
      name: "James Smith",
      email: "test_recp123@localhost",
      description: "Move on",
      type: "individual",
      bank_account: %{
        brand: "bbl",
        number: "acc12345",
        account_name: "James Smith"
      }
    }

    {:ok, recipient} = Omise.Recipients.create(params)
  ```

  """
  def create(%{name: name, email: email, description: description, type: type, bank_account: %{brand: brand, number: number, account_name: account_name}}) do
    Omise.process_url(@endpoint)
      |> HTTPoison.post({:form, [name: name, email: email, description: description, type: type, "bank_account[brand]": brand, "bank_account[number]": number, "bank_account[name]": account_name]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  @doc """
  Destroy a recipient.

  ## Example

  ```
    {:ok, recipient} = Omise.Recipients.destroy("recp_test_4z6p7e0m4k40txecj5o")
  ```

  """
  def destroy(id) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.delete(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end
end
