defmodule Omise.Config do
  @moduledoc false

  @permitted_params [:public_key, :secret_key, :api_version]

  @doc false
  def configure(params) do
    params
    |> Enum.filter(fn {k, _} -> k in @permitted_params end)
    |> Enum.map(fn {k, v} -> Application.put_env(:omise, k, v) end)
  end
end
