defmodule Omise.Config do
  @moduledoc false

  def configure(params) do
    params
    |> Enum.filter(fn {k,_} -> k in omise_env end)
    |> Enum.map(fn {k,v} -> Application.put_env(:omise, k, v) end)
  end

  defp omise_env do
    [:public_key, :secret_key, :api_version]
  end
end
