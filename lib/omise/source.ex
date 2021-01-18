defmodule Omise.Source do
  @moduledoc ~S"""
  Provides Source API interfaces.

  <https://www.omise.co/source-api>
  """

  use Omise.HTTPClient, endpoint: "sources"

  defstruct object: "source",
            id: nil,
            livemode: nil,
            location: nil,
            type: nil,
            flow: nil,
            amount: nil,
            currency: nil,
            barcode: nil,
            charge_status: nil,
            created: nil,
            installment_term: nil,
            mobile_number: nil,
            name: nil,
            phone_number: nil,
            store_id: nil,
            store_name: nil,
            terminal_id: nil,
            zero_interest_installments: nil,
            references: %Omise.Reference{},
            scannable_code: %Omise.ScannableCode{}

  @type t :: %__MODULE__{
          object: String.t(),
          id: String.t(),
          livemode: boolean,
          location: String.t(),
          type: String.t(),
          flow: String.t(),
          amount: integer,
          currency: String.t(),
          barcode: String.t(),
          charge_status: String.t(),
          created: String.t(),
          installment_term: integer,
          mobile_number: String.t(),
          name: String.t(),
          phone_number: String.t(),
          store_id: String.t(),
          store_name: String.t(),
          terminal_id: String.t(),
          zero_interest_installments: boolean,
          references: Omise.Reference.t(),
          scannable_code: Omise.ScannableCode.t()
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

  @doc ~S"""
  Retrieve a source.

  ## Examples

      Omise.Source.retrieve("src_test_5mkp04d53l2k1vtzmdi")

  """
  @spec retrieve(String.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end
end
