defmodule Omise do
  @moduledoc """
  Omise client library for Elixir.
  """

  @doc ~S"""
  Configure public_key, secret_key and api_version for Omise API.

  ## Examples

      # configure both public_key and secret_key
      Omise.configure(public_key: "public_key", secret_key: "secret_key")

      # configure only secret_key
      Omise.configure(secret_key: "secret_key")

      # configure api_verion
      Omise.configure(secret_key: "secret_key", api_verion: "api_verion")
  """
  defdelegate configure(list), to: Omise.Config
end
