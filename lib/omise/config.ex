defmodule Omise.Config do
  @moduledoc false

  @permitted_params ~w(
    public_key
    secret_key
    api_version
    base_vault_uri
    base_api_uri
    http_options
    decode
  )a

  @spec configure(Keyword.t) :: list
  def configure(params) do
    params
    |> Enum.filter(fn {k, _} -> k in @permitted_params end)
    |> Enum.map(fn {k, v} -> Application.put_env(:omise, k, v) end)
  end
end
