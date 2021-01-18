defmodule Omise.Capability do
  @moduledoc ~S"""
  Provides Capability API interfaces.

  <https://www.omise.co/capability-api>
  """

  use Omise.HTTPClient, endpoint: "capability"

  defstruct object: "capability",
            location: nil,
            banks: nil,
            country: nil,
            payment_methods: [%Omise.PaymentMethod{}],
            zero_interest_installments: nil

  @type t :: %__MODULE__{
          object: String.t(),
          location: String.t(),
          banks: list,
          country: String.t(),
          payment_methods: [Omise.PaymentMethod],
          zero_interest_installments: boolean
        }

  @doc ~S"""
  Retrieve the capability.

  Returns `{:ok, capability}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Capability.retrieve

  """
  @spec retrieve() :: {:ok, t} | {:error, Omise.Error.t()}
  def retrieve() do
    opts = Keyword.merge([], as: %__MODULE__{})
    get(@endpoint, [], opts)
  end
end
