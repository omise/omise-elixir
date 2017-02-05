defmodule Omise.Utils do
  @moduledoc false

  @spec encode_to_json(Keyword.t) :: iodata | no_return
  def encode_to_json(body_params) when is_list(body_params) do
    body_params
    |> normalize_req_body_params()
    |> Poison.encode!
  end

  defp normalize_req_body_params(params) when is_list(params) do
    params
    |> Enum.map(&transform_value/1)
    |> Enum.into(%{})
  end

  defp transform_value({key, value}) when is_list(value) do
    {key, Enum.into(normalize_req_body_params(value), %{})}
  end
  defp transform_value(kv) do
    kv
  end
end
