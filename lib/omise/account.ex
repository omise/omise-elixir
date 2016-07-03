defmodule Omise.Account do
  @moduledoc """
  Provides Account API interfaces.

  https://www.omise.co/account-api
  """

  defstruct [
    object:   "account",
    id:       nil,
    location: nil,
    email:    nil,
    created:  nil
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    id:       String.t,
    location: String.t,
    email:    String.t,
    created:  String.t
  }

  @endpoint "account"

  @doc """
  Retrieve the account.

  Returns `{:ok, account}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Account.retrieve

  """
  @spec retrieve :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def retrieve do
    Omise.HTTP.make_request(:get, @endpoint, as: %__MODULE__{})
  end
end
