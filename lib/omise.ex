defmodule Omise do
  @moduledoc false

  use HTTPoison.Base
  import Omise.Util, only: [handle_response: 1]
  import Omise.Version

  defdelegate configure(params), to: Omise.Config

  @doc false
  def make_request(method, endpoint, params \\ [], body \\ "") do
    method
    |> request!(endpoint, body, req_headers, auth(endpoint) ++ params)
    |> handle_response
  end

  @doc false
  def process_response_body(body) do
    try do
      case decoded_body = Poison.decode!(body, keys: :atoms) do
        %{object: "list", data: [%{object: object} | _]} ->
          Poison.decode!(body, keys: :atoms, as: %{data: [initialize_module(object)]})

        %{object: object} when object != "list" ->
          Poison.decode!(body, keys: :atoms, as: initialize_module(object))

        _ -> decoded_body
      end
    rescue
      _errors -> body
    end
  end

  @doc false
  def process_url(endpoint) do
    case endpoint do
      "tokens" -> "https://vault.omise.co/" <> endpoint
      _others  -> "https://api.omise.co/"   <> endpoint
    end
  end

  @doc false
  def req_headers do
    headers = %{
      "User-Agent"   => "OmiseElixir/#{omise_version} Elixir/#{elixir_version}",
      "Content-type" => "application/x-www-form-urlencoded",
    }
    if api_version, do: headers = headers |> Dict.put("Omise-Version", api_version)
    headers
  end

  defp auth("tokens"), do: vault_auth
  defp auth(_others),  do: api_auth

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

  def initialize_module(object) do
    Module.concat(__MODULE__, String.capitalize(object))
  end
end
