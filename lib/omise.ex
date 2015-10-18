defmodule Omise do
  @moduledoc """
  HTTP client for Omise.
  """

  alias Omise.Util

  def make_request(:get, endpoint) do
    process_url(endpoint)
    |> HTTPoison.get(req_headers, auth)
    |> Util.handle_response
  end

  def make_request(:post, endpoint, params) when endpoint == "tokens" do
    vault_url(endpoint)
    |> HTTPoison.post({:form, Util.transform_card_params(params)}, req_headers, vault_auth)
    |> Util.handle_response
  end

  def make_request(:post, endpoint, params) do
    process_url(endpoint)
    |> HTTPoison.post({:form, Util.transform_to_keyword(params)}, req_headers, auth)
    |> Util.handle_response
  end

  def make_request(:patch, endpoint, params) do
    process_url(endpoint)
    |> HTTPoison.patch({:form, Util.transform_to_keyword(params)}, req_headers, auth)
    |> Util.handle_response
  end

  def make_request(:delete, endpoint) do
    process_url(endpoint)
    |> HTTPoison.delete(req_headers, auth)
    |> Util.handle_response
  end

  def process_url(endpoint) do
    "https://api.omise.co/" <> endpoint
  end

  def vault_url(endpoint) do
    "https://vault.omise.co/" <> endpoint
  end

  def req_headers do
    %{"User-Agent": "Elixir Client"}
  end

  def secret_key do
    Application.get_env(:omise, :secret_key)
  end

  def public_key do
    Application.get_env(:omise, :public_key)
  end

  def auth do
    [hackney: [basic_auth: {secret_key, ""}]]
  end

  def vault_auth do
    [hackney: [basic_auth: {public_key, ""}]]
  end
end
