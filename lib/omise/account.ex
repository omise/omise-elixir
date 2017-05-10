defmodule Omise.Account do
  @moduledoc ~S"""
  Provides Account API interfaces.

  https://www.omise.co/account-api
  """

  import Omise.HTTP

  defstruct [
    object:   "account",
    id:       nil,
    location: nil,
    email:    nil,
    currency: nil,
    created:  nil
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    id:       String.t,
    location: String.t,
    email:    String.t,
    currency: String.t,
    created:  String.t
  }

  @endpoint "account"

  @doc ~S"""
  Retrieve the account.

  Returns `{:ok, account}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Account.retrieve

      Omise.Account.retrieve(key: "skey_56ia27lqtvg32u7iww8")

  """
  @spec retrieve(Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get(@endpoint, [], opts)
  end
end
