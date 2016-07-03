defmodule Omise.Config do
  @moduledoc false

  @doc false
  def configure(params) do
    params
    |> Enum.filter(fn {k, _} -> k in permitted_params end)
    |> Enum.map(fn {k, v} -> Application.put_env(:omise, k, v) end)
  end

  defp permitted_params do
    [:public_key, :secret_key, :api_version]
  end
end
