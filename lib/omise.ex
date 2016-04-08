defmodule Omise do
  @moduledoc """
  Omise client library for Elixir.
  """

  @doc """
  Configure public_key, secret_key and api_version for Omise API.

  ## Examples

      # configure both public_key and secret_key
      Omise.configure(public_key: "public_key", secret_key: "secret_key")

      # configure only secret_key
      Omise.configure(secret_key: "secret_key")

      # configure api_verion
      Omise.configure(secret_key: "secret_key", api_verion: "api_verion")
  """
  def configure(params) do
    Omise.Config.configure(params)
  end

  @doc false
  def make_request(method, endpoint, params \\ [], body \\ "") do
    Omise.HTTPClient.make_request(method, endpoint, params, body)
  end
end
