defmodule Omise do
  @moduledoc """
  Omise Elixir Client
  """

  alias Omise.Util

  @doc """
  GET request.
  """
  def get(endpoint) do
    api_url(endpoint)
    |> HTTPoison.get(req_headers, api_auth)
    |> Util.handle_response
  end

  @doc """
  POST request.
  """
  def post(endpoint, params \\ []) do
    case endpoint do
      "tokens" ->
        vault_url(endpoint)
        |> HTTPoison.post({:form, Util.transform_card_params(params)}, req_headers, vault_auth)
        |> Util.handle_response
      _others  ->
        api_url(endpoint)
        |> HTTPoison.post({:form, params}, req_headers, api_auth)
        |> Util.handle_response
    end
  end

  @doc """
  PUT/PATCH request.
  """
  def put(endpoint, params \\ []) do
    api_url(endpoint)
    |> HTTPoison.patch({:form, params}, req_headers, api_auth)
    |> Util.handle_response
  end

  @doc """
  DELETE request.
  """
  def delete(endpoint) do
    api_url(endpoint)
    |> HTTPoison.delete(req_headers, api_auth)
    |> Util.handle_response
  end

  def api_url(endpoint) do
    "https://api.omise.co/" <> endpoint
  end

  def vault_url(endpoint) do
    "https://vault.omise.co/" <> endpoint
  end

  def req_headers do
    %{"User-Agent": "Elixir Client"}
  end

  def public_key do
    Application.get_env(:omise, :public_key)
  end

  def secret_key do
    Application.get_env(:omise, :secret_key)
  end

  def api_auth do
    [hackney: [basic_auth: {secret_key, ""}]]
  end

  def vault_auth do
    [hackney: [basic_auth: {public_key, ""}]]
  end
end
