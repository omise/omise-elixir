defmodule Omise.Account do
  @moduledoc ~S"""
  Provides Account API interfaces.

  <https://www.omise.co/account-api>
  """

  use Omise.HTTPClient, endpoint: "account"

  defstruct object: "account",
            id: nil,
            livemode: nil,
            location: nil,
            email: nil,
            currency: nil,
            supported_currencies: nil,
            created: nil,
            api_version: nil,
            auto_activate_recipients: nil,
            chain_enabled: nil,
            chain_return_uri: nil,
            country: nil,
            metadata_export_keys: nil,
            team: nil,
            webhook_uri: nil

  @type t :: %__MODULE__{
          object: String.t(),
          id: String.t(),
          livemode: boolean,
          location: String.t(),
          email: String.t(),
          currency: String.t(),
          supported_currencies: list,
          created: String.t(),
          api_version: String.t(),
          auto_activate_recipients: boolean,
          chain_enabled: boolean,
          chain_return_uri: String.t(),
          country: String.t(),
          metadata_export_keys: map,
          team: String.t(),
          webhook_uri: String.t()
        }

  @doc ~S"""
  Retrieve the account.

  Returns `{:ok, account}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Account.retrieve

      Omise.Account.retrieve(key: "skey_56ia27lqtvg32u7iww8")

  """
  @spec retrieve(Keyword.t()) :: {:ok, t} | {:error, Omise.Error.t()}
  def retrieve(opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get(@endpoint, [], opts)
  end
end
