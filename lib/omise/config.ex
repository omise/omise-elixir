defmodule Omise.Config do
  @moduledoc false

  @permitted_keys ~w(
    public_key
    secret_key
    api_version
    base_vault_uri
    base_api_uri
    http_options
  )a

  @spec configure(Keyword.t()) :: list
  def configure(params) do
    params
    |> Keyword.take(@permitted_keys)
    |> Enum.map(fn {k, v} -> Application.put_env(:omise, k, v) end)
  end
end
