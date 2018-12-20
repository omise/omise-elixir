defmodule Omise.Utils do
  @moduledoc false

  @spec normalize_search_params(Keyword.t()) :: Keyword.t()
  def normalize_search_params(params) do
    filters_params = params[:filters] || []

    params
    |> Keyword.take([:query])
    |> Keyword.merge(normalize_filters_params(filters_params))
  end

  defp normalize_filters_params(filters_params) do
    Enum.flat_map(filters_params, fn {key, value} ->
      ["filters[#{key}]": value]
    end)
  end
end
