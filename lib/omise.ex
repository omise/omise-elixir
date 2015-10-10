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

  def key do
    Application.get_env(:omise, :secret_key) ||
      System.get_env "OMISE_SECRET_KEY"
  end

  def auth do
    [hackney: [basic_auth: {key, ""}]]
  end
end
