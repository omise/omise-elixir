defmodule Omise.Config do
  @moduledoc """
  Public key, secret key and api verion configuration.
  """

  @doc """
  Configure public_key, secret_key and api_version for Omise API.

  ## Examples

      # configure both public_key and secret_key
      Omise.Config.configure(public_key: "public_key", secret_key: "secret_key")

      # configure only secret_key
      Omise.Config.configure(secret_key: "secret_key")

      # configure api_verion
      Omise.Config.configure(secret_key: "secret_key", api_verion: "api_verion")
  """
  def configure(params) do
    params
    |> Enum.filter(fn {k,_} -> k in omise_env end)
    |> Enum.map(fn {k,v} -> Application.put_env(:omise, k, v) end)
  end

  defp omise_env do
    [:public_key, :secret_key, :api_version]
  end
end
