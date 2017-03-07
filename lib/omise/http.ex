defmodule Omise.HTTP do
  @moduledoc false

  alias Omise.{Utils, Version}

  @vault_endpoints ~w(tokens)
  @base_vault_uri  "https://vault.omise.co/"
  @base_api_uri    "https://api.omise.co/"

  @spec get(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, struct}
  def get(endpoint, query_params \\ [], opts \\ []) do
    request(:get, endpoint, [query_params: query_params], opts)
  end

  @spec post(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, struct}
  def post(endpoint, body_params \\ [], opts \\ []) do
    request(:post, endpoint, [body_params: body_params], opts)
  end

  @spec put(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, struct}
  def put(endpoint, body_params \\ [], opts \\ []) do
    request(:put, endpoint, [body_params: body_params], opts)
  end

  @spec delete(String.t, Keyword.t) :: {:ok, struct} | {:error, struct}
  def delete(endpoint, opts \\ []) do
    request(:delete, endpoint, [], opts)
  end

  @spec request(atom, String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, struct}
  def request(method, endpoint, request_params \\ [], opts \\ []) do
    key         = Keyword.get(opts, :key)
    api_version = Keyword.get(opts, :api_version, Version.api_version)
    as          = Keyword.fetch!(opts, :as)

    query_params = Keyword.get(request_params, :query_params, [])
    body_params  = Keyword.get(request_params, :body_params, [])

    {url, auth_params} = url_with_auth_params(endpoint, key)

    request_body    = Utils.encode_to_json(body_params)
    request_headers = req_headers(api_version)
    request_options = [params: query_params] ++ auth_params ++ http_options()

    method
    |> HTTPoison.request!(url, request_body, request_headers, request_options)
    |> handle_response(as: as)
  end

  defp handle_response(%HTTPoison.Response{body: body}, as: as) do
    case Poison.Parser.parse!(body) do
      %{"object" => "error"} ->
        {:error, Poison.decode!(body, as: %Omise.Error{})}

      _ ->
        {:ok, Poison.decode!(body, as: as)}
    end
  end

  defp url_with_auth_params(endpoint, key) when endpoint in @vault_endpoints do
    key      = key || Application.get_env(:omise, :public_key)
    base_uri = Application.get_env(:omise, :base_vault_uri, @base_vault_uri)
    {base_uri <> endpoint, auth_params(key)}
  end
  defp url_with_auth_params(endpoint, key) do
    key      = key || Application.get_env(:omise, :secret_key)
    base_uri = Application.get_env(:omise, :base_api_uri, @base_api_uri)
    {base_uri <> endpoint, auth_params(key)}
  end

  defp auth_params(key) do
    [hackney: [basic_auth: {key, ""}]]
  end

  defp req_headers(api_version) do
    if api_version do
      Map.merge(default_req_headers(), %{"Omise-Version" => api_version})
    else
      default_req_headers()
    end
  end

  defp default_req_headers do
    %{"User-Agent" => user_agent(), "Content-type" => "application/json"}
  end

  defp user_agent do
    "OmiseElixir/#{Version.project_version} Elixir/#{Version.elixir_version}"
  end

  defp http_options do
    Keyword.merge(
      [timeout: 10_000, recv_timeout: 10_000],
      Application.get_env(:omise, :http_options, [])
    )
  end
end
