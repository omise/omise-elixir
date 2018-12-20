defmodule Omise.Json do
  alias Omise.Json.{Decoder, Encoder}

  defdelegate encode(input), to: Encoder
  defdelegate decode(input, opts \\ []), to: Decoder
end

defmodule Omise.Json.Encoder do
  def encode(input) do
    input
    |> transform_data()
    |> Jason.encode()
    |> case do
      {:ok, output} ->
        {:ok, output}

      _ ->
        {:error, :invalid_input_data}
    end
  end

  defp transform_data(data) when is_list(data) or is_map(data) do
    data
    |> Enum.map(&do_transform_data/1)
    |> Enum.into(%{})
  end

  defp transform_data(data) do
    data
  end

  defp do_transform_data({key, [head | _] = value}) when is_tuple(head) do
    {key, transform_data(value)}
  end

  defp do_transform_data(kv) do
    kv
  end
end

defmodule Omise.Json.Decoder do
  alias Omise.Json.StructTransformer

  def decode(input, opts) do
    case Jason.decode(input) do
      {:ok, output} ->
        {:ok, transform_decoded_data(output, opts)}

      _ ->
        {:error, :invalid_input_data}
    end
  end

  def transform_decoded_data(decoded_data, opts) do
    case Keyword.fetch(opts, :as) do
      {:ok, struct} ->
        to_struct(decoded_data, struct)

      :error ->
        decoded_data
    end
  end

  defp to_struct(decoded_data, struct) do
    fields = extract_fields_from_struct(struct, decoded_data)

    struct.__struct__
    |> struct(fields)
    |> StructTransformer.transform()
  end

  defp extract_fields_from_struct(struct, decoded_data) do
    struct
    |> Map.from_struct()
    |> Enum.reduce(%{}, fn {key, default_value}, acc ->
      value =
        decoded_data
        |> Map.get(Atom.to_string(key))
        |> transform_value(default_value)

      Map.put(acc, key, value)
    end)
  end

  defp transform_value(nil, %{__struct__: _}), do: nil
  defp transform_value(nil, default_value), do: default_value
  defp transform_value(value, %{__struct__: _} = struct), do: to_struct(value, struct)
  defp transform_value(values, [struct]), do: Enum.map(values, &transform_value(&1, struct))
  defp transform_value(value, _), do: value
end

defprotocol Omise.Json.StructTransformer do
  @fallback_to_any true

  @spec transform(struct()) :: struct()
  def transform(struct)
end

defimpl Omise.Json.StructTransformer, for: Any do
  def transform(struct) do
    struct
  end
end
