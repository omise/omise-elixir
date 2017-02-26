defmodule Omise.Balance do
  @moduledoc ~S"""
  Provides Balance API interfaces.

  https://www.omise.co/balance-api
  """

  import Omise.HTTP

  defstruct [
    object:    "balance",
    livemode:  nil,
    location:  nil,
    available: nil,
    total:     nil,
    currency:  nil
  ]

  @type t :: %__MODULE__{
    object:    String.t,
    livemode:  boolean,
    location:  String.t,
    available: integer,
    total:     integer,
    currency:  String.t
  }

  @endpoint "balance"

  @doc ~S"""
  Retrieve the balance.

  Returns `{:ok, balance}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Balance.retrieve

      Omise.Balance.retrieve(key: "skey_56ia27lqtvg32u7iww8")

  """
  @spec retrieve(Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get(@endpoint, [], opts)
  end
end
