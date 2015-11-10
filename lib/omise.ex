defmodule Omise do
  @moduledoc """
  Omise Elixir Client
  """

  use HTTPoison.Base
  import Omise.Util, only: [handle_response: 1]
  import Omise.Version

  @doc """
  Configure public_key, secret_key and api_version for Omise API.

  ## Examples

      # configure both public_key and secret_key
      Omise.config(public_key: "public_key", secret_key: "secret_key")

      # configure only secret_key
      Omise.config(secret_key: "secret_key")

      # configure api_verion
      Omise.config(secret_key: "secret_key", api_verion: "api_verion")
  """
  def configure(params) do
    params
    |> Enum.filter(fn {k,_} -> k in omise_env end)
    |> Enum.map(fn {k,v} -> Application.put_env(:omise, k, v) end)
  end

  @doc false
  def make_request(method, endpoint, params \\ [], body \\ "") do
    method
    |> request!(endpoint, body, req_headers, auth(endpoint) ++ params)
    |> handle_response
  end

  @doc false
  def process_response_body(body) do
    case decoded_body = Poison.decode!(body, keys: :atoms) do
      %{object: "list", data: [%{object: object} | _]} ->
        Poison.decode!(body, keys: :atoms!, as: %{data: [initialize_module(object)]})

      %{object: object} when object != "list" ->
        Poison.decode!(body, keys: :atoms!, as: initialize_module(object))

      _ ->
        decoded_body
    end
  end

  @doc false
  def process_url(endpoint) do
    case endpoint do
      "tokens" -> "http://vault.omise.co/" <> endpoint
      _others  -> "http://api.omise.co/"   <> endpoint
    end
  end

  @doc false
  def req_headers do
    headers = %{
      "User-Agent"    => "OmiseElixir/#{omise_version} Elixir/#{elixir_version}",
      "Content-type"  => "application/x-www-form-urlencoded",
    }
    if api_version, do: headers = headers |> Dict.put("Omise-Version", api_version)
    headers
  end

  defp auth(endpoint) do
    case endpoint do
      "tokens" -> vault_auth
      _others  -> api_auth
    end
  end

  defp api_auth do
    [hackney: [basic_auth: {secret_key, ""}]]
  end

  defp vault_auth do
    [hackney: [basic_auth: {public_key, ""}]]
  end

  defp public_key do
    Application.get_env(:omise, :public_key) || System.get_env("OMISE_PUBLIC_KEY")
  end

  defp secret_key do
    Application.get_env(:omise, :secret_key) || System.get_env("OMISE_SECRET_KEY")
  end

  defp omise_env do
    [:public_key, :secret_key, :api_version]
  end

  defp initialize_module(object) do
    Module.concat(__MODULE__, String.capitalize(object))
  end
end
