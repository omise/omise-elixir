defmodule Omise do
  @moduledoc """
  Omise Elixir Client
  """

  use HTTPoison.Base
  import Omise.Util, only: [handle_response: 1]
  import Omise.Version

  @doc """
  Configure public_key and secret_key for Omise API.

  ## Examples

  ```
    Omise.config(public_key: "public_key", secret_key: "secret_key", api_version: "2014-07-27")
  ```

  """
  def configure(params) do
    params
    |> Enum.filter(fn {k,_} -> k in omise_env end)
    |> Enum.map(fn {k,v} -> Application.put_env(:omise, k, v) end)
  end

  @doc """
  Make a request to Omise API
  """
  def make_request({:get, endpoint}) do
    endpoint
    |> get!(req_headers, auth(endpoint))
    |> handle_response
  end
  def make_request({:post, endpoint, params}) do
    endpoint
    |> post!({:form, params}, req_headers, auth(endpoint))
    |> handle_response
  end
  def make_request({:patch, endpoint, params}) do
    endpoint
    |> patch!({:form, params}, req_headers, auth(endpoint))
    |> handle_response
  end
  def make_request({:delete, endpoint}) do
    endpoint
    |> delete!(req_headers, auth(endpoint))
    |> handle_response
  end

  @doc false
  def process_response_body(body) do
    Poison.decode!(body, keys: :atoms)
  end

  @doc false
  def process_url(endpoint) do
    case endpoint do
      "tokens" -> "https://vault.omise.co/" <> endpoint
      _others  -> "https://api.omise.co/" <> endpoint
    end
  end

  @doc false
  def req_headers do
    headers = %{
      "User-Agent"    => "OmiseElixir/#{omise_version} Elixir/#{elixir_version}",
      "Content-type"  => "application/x-www-form-urlencoded",
    }
    if api_version, do: headers.put("Omise-Version", api_version)
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
end
