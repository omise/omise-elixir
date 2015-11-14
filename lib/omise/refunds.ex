defmodule Omise.Refunds do
  @moduledoc """
  Provides Refunds API interfaces.
  """

  @endpoint "refunds"

  @doc """
  List all refunds.

  Returns `{:ok, refunds}` if the request is successful, `{:error, error}` otherwise.

  Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      {:ok, charge}  = Omise.Charges.retrieve("chrg_test_520jim7x8u6t4si58va")
      {:ok, refunds} = charge |> Omise.refunds.list(limit: 2)

  """
  @spec list(Omise.Charge.t, Keyword.t) :: {:ok, [Omise.Refund.t]} | {:error, Omise.Error.t}
  def list(charge, params \\ []) do
    Omise.make_request(:get, "charges/#{charge.id}/#{@endpoint}",  [params: params])
  end

  @doc """
  Retrieve a refund.

  Returns `{:ok, refund}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      {:ok, charge} = Omise.Charges.retrieve("chrg_test_520jim7x8u6t4si58va")
      {:ok, refund} = charge |> Omise.Refunds.retrieve("dspt_test_51yfnnpsxajeybpytm4")

  """
  @spec retrieve(Omise.Charge.t, String.t) :: {:ok, Omise.Refund.t} | {:error, Omise.Error.t}
  def retrieve(charge, id) do
    Omise.make_request(:get, "charges/#{charge.id}/#{@endpoint}/#{id}")
  end

  @doc """
  Create a refund.

  Returns `{:ok, refund}` if the request is successful, `{:error, error}` otherwise.

  Request Parameters:
    * `amount` - The amount in the smallest subunits of the currency used.
      So for thb (Thai Baht) you'll need to pass the amount in satangs.

  ## Examples

      {:ok, charge} = Omise.Charges.retrieve("chrg_test_520jim7x8u6t4si58va")
      {:ok, refund} = charge |> Omise.Refunds.create(amount: 100_00)

  """
  @spec create(Omise.Charge.t, Keyword.t) :: {:ok, Omise.Refund.t} | {:error, Omise.Error.t}
  def create(charge, params) do
    Omise.make_request(:post, "charges/#{charge.id}/#{@endpoint}", [], {:form, params})
  end
end
