defmodule Omise.Utils do
  @moduledoc false

  def encode_to_json(body_params) when is_list(body_params) do
    body_params
    |> normalize_params()
    |> Poison.encode!()
  end

  def normalize_search_params(params) do
    filters_params = params[:filters] || []

    params
    |> Keyword.take([:query])
    |> Keyword.merge(normalize_filters_params(filters_params))
  end

  defp normalize_params(params) when is_list(params) do
    params
    |> Enum.map(&transform_value/1)
    |> Enum.into(%{})
  end

  defp transform_value({key, [head | _] = value}) when is_tuple(head),
    do: {key, Enum.into(normalize_params(value), %{})}

  defp transform_value(kv), do: kv

  defp normalize_filters_params(filters_params) do
    Enum.flat_map(filters_params, fn {key, value} ->
      ["filters[#{key}]": value]
    end)
  end
end
