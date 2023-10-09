defmodule Omise.Charge do
  @moduledoc ~S"""
  Provides Charge API interfaces.

  <https://www.omise.co/charges-api>
  """

  use Omise.HTTPClient, endpoint: "charges"

  defstruct object: "charge",
            id: nil,
            livemode: nil,
            location: nil,
            amount: nil,
            authorization_type: nil,
            authorized_amount: nil,
            captured_amount: nil,
            currency: nil,
            description: nil,
            metadata: nil,
            status: nil,
            capture: nil,
            authorized: nil,
            reversed: nil,
            captured: nil,
            expired: nil,
            capturable: nil,
            disputable: nil,
            refundable: nil,
            reversible: nil,
            paid: nil,
            branch: nil,
            device: nil,
            transaction: nil,
            source_of_fund: nil,
            refunded: nil,
            refunds: %Omise.List{data: [%Omise.Refund{}]},
            return_uri: nil,
            offsite: nil,
            offline: nil,
            installment_terms: nil,
            reference: nil,
            authorize_uri: nil,
            failure_code: nil,
            failure_message: nil,
            card: %Omise.Card{},
            customer: nil,
            ip: nil,
            fee: nil,
            fee_vat: nil,
            interest: nil,
            interest_vat: nil,
            net: nil,
            platform_fee: nil,
            funding_amount: nil,
            funding_currency: nil,
            refunded_amount: nil,
            dispute: %Omise.Dispute{},
            created: nil,
            expired_at: nil,
            expires_at: nil,
            link: nil,
            schedule: nil,
            terminal: nil,
            zero_interest_installments: nil,
            source: %Omise.Source{}

  @type t :: %__MODULE__{
          object: String.t(),
          id: String.t(),
          livemode: boolean,
          location: String.t(),
          amount: String.t(),
          currency: String.t(),
          description: String.t(),
          metadata: map,
          status: String.t(),
          capture: boolean,
          authorized: boolean,
          reversed: boolean,
          captured: boolean,
          expired: boolean,
          capturable: boolean,
          disputable: boolean,
          refundable: boolean,
          reversible: boolean,
          paid: boolean,
          branch: String.t(),
          device: String.t(),
          transaction: String.t(),
          source_of_fund: String.t(),
          refunded: String.t(),
          refunds: Omise.List.t(),
          return_uri: String.t(),
          offsite: String.t(),
          offline: map,
          installment_terms: integer,
          reference: String.t(),
          authorize_uri: String.t(),
          failure_code: String.t(),
          failure_message: String.t(),
          card: Omise.Card.t(),
          customer: String.t(),
          ip: String.t(),
          fee: integer,
          fee_vat: integer,
          interest: integer,
          interest_vat: integer,
          net: integer,
          platform_fee: integer,
          funding_amount: integer,
          funding_currency: String.t(),
          refunded_amount: integer,
          dispute: Omise.Dispute.t(),
          created: String.t(),
          expired_at: String.t(),
          expires_at: String.t(),
          link: String.t(),
          schedule: String.t(),
          terminal: String.t(),
          zero_interest_installments: boolean,
          source: Omise.Source.t()
        }

  @doc ~S"""
  List all charges.

  Returns `{:ok, charges}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Charge.list

      Omise.Charge.list(limit: 10)

  """
  @spec list(Keyword.t(), Keyword.t()) :: {:ok, Omise.List.t()} | {:error, Omise.Error.t()}
  def list(params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get(@endpoint, params, opts)
  end

  @doc ~S"""
  Retrieve a charge.

  ## Examples

      Omise.Charge.retrieve("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec retrieve(String.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end

  @doc ~S"""
  Create a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `customer` - (required or optional) A valid `CUSTOMER_ID` that has at least one card already associated.
      By default the default card of the customer will be used.
      This parameter is required unless passing a `TOKEN_ID` in the card parameter.
    * `card` - (required or optional) A valid unused `TOKEN_ID` or `CARD_ID`.
      In the case of the `CARD_ID` the customer parameter must be present and be the owner of the card.
      For the `TOKEN_ID`, the customer must not be passed.
    * `amount` - (required) The amount in the smallest subunits of the currency used.
      For thb (Thai Baht) you'll need to pass the amount in satangs.
    * `currency` - (required) The currency in which you want the charge to be done. The default and only valid value is thb.
    * `description` - (optional) A custom description for the charge. This value can be searched for in your dashboard.
    * `capture` - (optional) Whether or not you want the charge to be captured right away, when not specified it is set to true.
    * `return_uri` - (optional) The url where we will return the customer after the charge has been authorized with 3-D Secure.

  ## Examples

      # Charge a card using a token.
      Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        card: "tokn_test_51w6fvilnsxalda4cih"
      )

      # Charge a card using a customer.
      Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        customer: "cust_test_51vtchzn51al0jaa92q"
      )

      # Charge a card using a customer and a card.
      Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        customer: "cust_test_51vtchzn51al0jaa92q",
        card: "card_test_51w6jblhhpzmc2g8bcm"
      )

      # Create an internet banking charge
      Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        return_uri: "https://example.com/orders/123/complete",
        source: "src_test_59vbms154ab4pe4jh2i"
      )

      # Create a bill payment charge
      Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        source: "src_test_59vb8av645gxw48glui"
      )

  """
  @spec create(Keyword.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def create(params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    post(@endpoint, params, opts)
  end

  @doc ~S"""
  Update a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `description` - (optional) A custom description for the charge. This value can be searched for in your dashboard.

  ## Examples

      Omise.Charge.update("chrg_test_4xso2s8ivdej29pqnhz",
        description: "The funny thing is that when I am okay, oh it makes me wish for rain")

  """
  @spec update(String.t(), Keyword.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def update(id, params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    patch("#{@endpoint}/#{id}", params, opts)
  end

  @doc ~S"""
  Capture a charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ***NOTE***:
  If you have created a charge and passed `capture=false` you'll have an authorized only charge that you can capture at a later time.
  You can hold it for as long as permitted by the issuing bank. This delay may vary between cards from 1 to 30 days.
  To create a partial capture charge you must set your charge `authorization_type="pre_auth"` and `capture=false` then you can partially capture the charge with `capture_amount=amount`

  ## Examples

      Omise.Charge.capture("chrg_test_4xso2s8ivdej29pqnhz")
      Omise.Charge.capture("chrg_test_4xso2s8ivdej29pqnhz", key: "skey_test_123", capture_amount: 3000)

  """
  @spec capture(String.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def capture(id, opts \\ []) do
    {params, opts} = Keyword.split(opts, [:capture_amount])
    opts = Keyword.merge(opts, as: %__MODULE__{})
    post("#{@endpoint}/#{id}/capture", params, opts)
  end

  @doc ~S"""
  Reverse an uncaptured charge.

  Returns `{:ok, charge}` if the request is successful, `{:error, error}` otherwise.

  ***NOTE***:
  If you have created a charge and passed `capture=false`,
  you'll have an authorized only charge that can be reversed, release hold money, at a later time.

  ## Examples

      Omise.Charge.reverse("chrg_test_4xso2s8ivdej29pqnhz")

  """
  @spec reverse(String.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def reverse(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    post("#{@endpoint}/#{id}/reverse", [], opts)
  end

  @doc ~S"""
  Search all the charges.

  Returns `{:ok, charges}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:

      <https://www.omise.co/search-query-and-filters>

  ## Examples

      Omise.Charge.search(filters: [paid: true])

      Omise.Charge.search(query: "omise")

  """
  @spec search(Keyword.t(), Keyword.t()) :: {:ok, Omise.Search.t()} | {:error, Omise.Error.t()}
  def search(params \\ [], opts \\ []) do
    Omise.Search.execute("charge", params, opts)
  end

  @doc ~S"""
  Create a refund.

  Returns `{:ok, refund}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `amount` - The amount in the smallest subunits of the currency used.
      So for thb (Thai Baht) you'll need to pass the amount in satangs.

  ## Examples

      Omise.Charge.refund("chrg_test_520jim7x8u6t4si58va", amount: 100_00)

  """
  @spec refund(String.t(), Keyword.t(), Keyword.t()) :: {:ok, Omise.Refund.t()} | {:error, Omise.Error.t()}
  def refund(id, params, opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.Refund{})
    post("#{@endpoint}/#{id}/refunds", params, opts)
  end

  @doc ~S"""
  List all refunds.

  Returns `{:ok, refunds}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Charge.list_refunds("chrg_test_52oo08bwpgnwb95rye8")

  """
  @spec list_refunds(String.t(), Keyword.t(), Keyword.t()) :: {:ok, Omise.List.t()} | {:error, Omise.Error.t()}
  def list_refunds(id, params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%Omise.Refund{}]})
    get("#{@endpoint}/#{id}/refunds", params, opts)
  end

  @doc ~S"""
  Retrieve a refund.

  Returns `{:ok, refund}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Charge.retrieve_refund("chrg_test_520jim7x8u6t4si58va", "rfnd_test_4zgf1d7jcw5kr123puq")

  """
  @spec retrieve_refund(String.t(), String.t(), Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def retrieve_refund(id, refund_id, opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.Refund{})
    get("#{@endpoint}/#{id}/refunds/#{refund_id}", [], opts)
  end

  @doc ~S"""
  List all charge schedules.

  Returns `{:ok, schedules}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Charge.list_schedules

  """
  @spec list_schedules(Keyword.t(), Keyword.t()) :: {:ok, Omise.List.t()} | {:error, Omise.Error.t()}
  def list_schedules(params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%Omise.Schedule{}]})
    get("#{@endpoint}/schedules", params, opts)
  end
end
