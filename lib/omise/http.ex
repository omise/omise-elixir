defmodule Omise.HTTP do
  @moduledoc false

  @vault_url "https://vault.omise.co/"
  @api_url   "https://api.omise.co/"

  import Omise.Version

  @doc false
  def make_request(method, endpoint, options) do
    req_body    = options[:body] || ""
    req_params  = (options[:params] && [params: options[:params]]) || []
    {url, auth} = url_with_basic_auth(endpoint)

    method
    |> HTTPoison.request!(url, req_body, req_headers, auth ++ req_params)
    |> handle_response(as: options[:as])
  end

  defp url_with_basic_auth(endpoint) do
    if request_to_vault?(endpoint) do
      {@vault_url <> endpoint, vault_auth}
    else
      {@api_url <> endpoint, api_auth}
    end
  end

  defp handle_response(%HTTPoison.Response{body: body}, as: as) do
    case Poison.Parser.parse!(body) do
      %{"object" => "error"} ->
        {:error, Poison.decode!(body, as: %Omise.Error{})}

      _ ->
        {:ok, Poison.decode!(body, as: as)}
    end
  end

  defp request_to_vault?(endpoint) do
    String.starts_with?(endpoint, "tokens")
  end

  defp api_auth do
    [hackney: [basic_auth: {secret_key, ""}]]
  end

  defp vault_auth do
    [hackney: [basic_auth: {public_key, ""}]]
  end

  defp public_key, do: Application.get_env(:omise, :public_key)

  defp secret_key, do: Application.get_env(:omise, :secret_key)

  defp req_headers do
    case api_version do
      nil -> default_req_headers
      _   -> Map.merge(default_req_headers, %{"Omise-Version" => api_version})
    end
  end

  defp default_req_headers do
    %{"User-Agent"   => "OmiseElixir/#{project_version} Elixir/#{elixir_version}",
      "Content-type" => "application/x-www-form-urlencoded"}
  end
end
