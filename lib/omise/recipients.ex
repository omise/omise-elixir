defmodule Omise.Recipients do
  @moduledoc """
  Provides Recipients API interfaces.

  https://www.omise.co/recipients-api
  """

  @endpoint "recipients"

  @doc """
  List all recipients.

  Returns `{:ok, recipients}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      {:ok, recipients} = Omise.Recipients.list

      {:ok, recipients} = Omise.Recipients.list(limit: 5)

  """
  @spec list(Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def list(params \\ []) do
    Omise.make_request(:get, @endpoint, [params: params])
  end

  @doc """
  Retrieve a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, recipient} = Omise.Recipients.retrieve("recp_test_4z6p7e0m4k40txecj5o")

  """
  @spec retrieve(String.t) :: {:ok, Map.t} | {:error, Map.t}
  def retrieve(id) do
    Omise.make_request(:get, "#{@endpoint}/#{id}")
  end

  @doc """
  Create a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `name` - The recipient's name.
    * `email` - (optional) The recipient's email.
    * `description` - (optional) The recipient's description.
    * `type` - Either individual or corporation.
    * `tax_id` - (optional) The recipient's tax id.
    * `bank_account` - A valid bank account.

  ## Examples

      params = [
        name: "Edward Elric",
        email: "edward@omistry.com",
        description: "Go away!",
        type: "individual",
        bank_account: [
          brand: "bbl",
          number: "1234567890",
          name: "Edward Elric"
        ]
      ]

      {:ok, recipient} = Omise.Recipients.create(params)

  """
  @spec create(Keyword.t) :: {:ok, Map.t} | {:error, Map.t}
  def create(params) do
    Omise.make_request(:post, @endpoint, [], {:form, Omise.Util.normalize_recipient_params(params)})
  end

  @doc """
  Destroy a recipient.

  Returns `{:ok, recipient}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, recipient} = Omise.Recipients.destroy("recp_test_4z6p7e0m4k40txecj5o")

  """
  @spec destroy(String.t) :: {:ok, Map.t} | {:error, Map.t}
  def destroy(id) do
    Omise.make_request(:delete, "#{@endpoint}/#{id}")
  end
end
