defmodule Omise.HTTPClient do
  @moduledoc false

  @base_vault_uri "https://vault.omise.co/"
  @base_api_uri   "https://api.omise.co/"

  @default_req_headers %{
    "User-Agent"   => "OmiseElixir/#{Mix.Project.config[:version]} Elixir/#{System.version}",
    "Content-type" => "application/json",
  }
  @default_http_options [timeout: :timer.seconds(60), recv_timeout: :timer.seconds(60)]

  defmacro __using__(options) do
    quote bind_quoted: [options: options] do
      import Omise.HTTPClient, only: [request: 5]

      @endpoint Keyword.fetch!(options, :endpoint)
      @key_type Keyword.get(options, :key_type, :secret_key)

      defp get(endpoint, query_params \\ [], options \\ []) do
        request(:get, @key_type, endpoint, [query_params: query_params], options)
      end

      defp post(endpoint, body_params \\ [], options \\ []) do
        request(:post, @key_type, endpoint, [body_params: body_params], options)
      end

      defp put(endpoint, body_params \\ [], options \\ []) do
        request(:put, @key_type, endpoint, [body_params: body_params], options)
      end

      defp delete(endpoint, options \\ []) do
        request(:delete, @key_type, endpoint, [], options)
      end
    end
  end

  def request(method, key_type, endpoint, req_params \\ [], options \\ []) do
    key         = Keyword.get(options, :key,         Application.get_env(:omise, key_type)) || raise "Expects #{key_type} to be set"
    api_version = Keyword.get(options, :api_version, Application.get_env(:omise, :api_version))
    decode      = Keyword.get(options, :decode,      Application.get_env(:omise, :decode, true))

    query_params = Keyword.get(req_params, :query_params, [])
    body_params  = Keyword.get(req_params, :body_params, [])

    url         = base_uri(key_type) <> endpoint
    req_body    = process_request_body(body_params)
    req_headers = process_request_headers(api_version)
    req_options = process_request_options(query_params, key)

    method
    |> HTTPoison.request!(url, req_body, req_headers, req_options)
    |> handle_response(%{decode: decode})
  end

  defp base_uri(:secret_key), do: Application.get_env(:omise, :base_vault_uri, @base_api_uri)
  defp base_uri(:public_key), do: Application.get_env(:omise, :base_api_uri, @base_vault_uri)

  defp process_request_body({:multipart, _} = req_body), do: req_body
  defp process_request_body(req_body),                   do: Omise.Utils.encode_to_json(req_body)

  defp process_request_headers(nil),         do: @default_req_headers
  defp process_request_headers(api_version), do: Map.merge(@default_req_headers, %{"Omise-Version" => api_version})

  defp process_request_options(query_params, key), do: [params: query_params] ++ auth_params(key) ++ http_options()

  defp auth_params(key), do: [hackney: [basic_auth: {key, ""}]]

  defp http_options, do: Keyword.merge(@default_http_options, Application.get_env(:omise, :http_options, []))

  defp handle_response(%HTTPoison.Response{body: body, headers: headers}, %{decode: decode}) do
    parsed_body = Poison.Parser.parse!(body)
    decode      = Omise.Utils.to_boolean(decode)

    cond do
      parsed_body["object"] == "error" && not decode ->
        {:error, parsed_body}

      parsed_body["object"] == "error" && decode ->
        {:error, Omise.Decoder.decode(parsed_body)}

      not decode ->
        {:ok, parsed_body}

      decode ->
        {:ok, Omise.Decoder.decode(parsed_body, version: returned_version(headers))}
    end
  end

  defp returned_version(headers) do
    headers
    |> Enum.into(%{})
    |> Map.get("Omise-Version")
    |> String.replace(~r/[^0-9]/, "")
    |> String.replace_prefix("", "V")
  end
end
