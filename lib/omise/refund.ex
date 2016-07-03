defmodule Omise.Refund do
  @moduledoc """
  Provides Refunds API interfaces.

  https://www.omise.co/refunds-api
  """

  defstruct [
    object:      "refund",
    id:          nil,
    location:    nil,
    amount:      nil,
    currency:    nil,
    voided:      nil,
    charge:      nil,
    transaction: nil,
    created:     nil
  ]

  @type t :: %__MODULE__{
    object:      String.t,
    id:          String.t,
    location:    String.t,
    amount:      Integer.t,
    currency:    String.t,
    voided:      boolean,
    charge:      String.t,
    transaction: String.t,
    created:     String.t
  }

  @endpoint "refunds"

  @doc """
  List all refunds.

  Returns `{:ok, refunds}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Refund.list("chrg_test_52oo08bwpgnwb95rye8")

      Omise.Refund.list("chrg_test_52oo08bwpgnwb95rye8", limit: 2)

  """
  @spec list(String.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(charge_id, params \\ []) do
    Omise.HTTP.make_request(:get, "charges/#{charge_id}/#{@endpoint}", params: params, as: %Omise.List{data: [%__MODULE__{}]})
  end

  @doc """
  Retrieve a refund.

  Returns `{:ok, refund}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Refund.retrieve("chrg_test_520jim7x8u6t4si58va", "rfnd_test_4zgf1d7jcw5kr123puq")

  """
  @spec retrieve(String.t, String.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def retrieve(charge_id, id) do
    Omise.HTTP.make_request(:get, "charges/#{charge_id}/#{@endpoint}/#{id}", as: %__MODULE__{})
  end

  @doc """
  Create a refund.

  Returns `{:ok, refund}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `amount` - The amount in the smallest subunits of the currency used.
      So for thb (Thai Baht) you'll need to pass the amount in satangs.

  ## Examples

      Omise.Refund.create("chrg_test_520jim7x8u6t4si58va", amount: 100_00)

  """
  @spec create(String.t, Keyword.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def create(charge_id, params) do
    Omise.HTTP.make_request(:post, "charges/#{charge_id}/#{@endpoint}", body: {:form, params}, as: %__MODULE__{})
  end
end
