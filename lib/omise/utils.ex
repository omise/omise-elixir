defmodule Omise.Utils do
  @moduledoc false

  @spec encode_to_json(Keyword.t) :: iodata | no_return
  def encode_to_json(body_params) when is_list(body_params) do
    body_params
    |> normalize_params()
    |> Poison.encode!
  end

  defp normalize_params(params) when is_list(params) do
    params
    |> Enum.map(&transform_value/1)
    |> Enum.into(%{})
  end

  defp transform_value({key, [head | _] = value}) when is_tuple(head),
    do: {key, Enum.into(normalize_params(value), %{})}
  defp transform_value(kv),
    do: kv
end
