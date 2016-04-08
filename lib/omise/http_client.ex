defmodule Omise.HTTPClient do
  @moduledoc false

  use HTTPoison.Base
  import Omise.{Util, Version}

  def make_request(method, endpoint, params \\ [], body \\ "") do
    method
    |> request!(endpoint, body, req_headers, auth(endpoint) ++ params)
    |> handle_response
  end

  def process_url(endpoint) do
    case endpoint do
      "tokens" -> "https://vault.omise.co/" <> endpoint
      _others  -> "https://api.omise.co/"   <> endpoint
    end
  end

  defp req_headers do
    case api_version do
      nil -> default_req_headers
      _   -> Map.merge(default_req_headers, %{"Omise-Version" => api_version})
    end
  end

  defp default_req_headers do
    %{"User-Agent"   => "OmiseElixir/#{omise_version} Elixir/#{elixir_version}",
      "Content-type" => "application/x-www-form-urlencoded"}
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
    Application.get_env(:omise, :public_key) ||
      System.get_env("OMISE_PUBLIC_KEY")
  end

  defp secret_key do
    Application.get_env(:omise, :secret_key) ||
      System.get_env("OMISE_SECRET_KEY")
  end
end
