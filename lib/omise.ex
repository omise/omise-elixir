defmodule Omise do
  @moduledoc """
  HTTP client for Omise.
  """

  def process_url(endpoint) do
    "https://api.omise.co/" <> endpoint
  end

  def req_headers do
    %{"User-Agent": "Elixir Client"}
  end

  def secret_key do
    Application.get_env(:omise, :secret_key) ||
      System.get_env "OMISE_SECRET_KEY"
  end

  def public_key do
    Application.get_env(:omise, :public_key) ||
      System.get_env "OMISE_PUBLIC_KEY"
  end

  def auth do
    [hackney: [basic_auth: {secret_key, ""}]]
  end

  def vault_auth do
    [hackney: [basic_auth: {public_key, ""}]]
  end
end
