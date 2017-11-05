defmodule Omise.Source do
  @moduledoc ~S"""
  Provides Source API interfaces.

  <https://www.omise.co/source-api>
  """

  use Omise.HTTPClient, endpoint: "sources"

  defstruct object: "source",
            id: nil,
            type: nil,
            flow: nil,
            amount: nil,
            currency: nil

  @type t :: %__MODULE__{
          object: String.t(),
          id: String.t(),
          type: String.t(),
          flow: String.t(),
          amount: integer,
          currency: String.t()
        }

  @doc ~S"""
  Create a source.

  Returns `{:ok, source}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `type` - (required) The source payment type. See attribute section above for the available types.
    * `amount` - (required) The amount in the smallest subunits of the currency used.
    * `currency` - (required) The currency in which you want the payment to be done.

  ## Examples

      # Create with default secret key.
      Omise.Source.create(
        type: "bill_payment_tesco_lotus",
        amount: 1000_00,
        currency: "thb"
      )

      # Create with custom public/secret key.
      Omise.Source.create(
        [
          type: "bill_payment_tesco_lotus",
          amount: 1000_00,
          currency: "thb"
        ],
        key: "pkey_xxx"
      )

  """
  @spec create(Keyword.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def create(params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    post(@endpoint, params, opts)
  end
end
