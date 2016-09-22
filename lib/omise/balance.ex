defmodule Omise.Balance do
  @moduledoc """
  Provides Balance API interfaces.

  https://www.omise.co/balance-api
  """

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

  @doc """
  Retrieve the balance.

  Returns `{:ok, balance}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Balance.retrieve

  """
  @spec retrieve :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve do
    Omise.HTTP.make_request(:get, @endpoint, as: %__MODULE__{})
  end
end
