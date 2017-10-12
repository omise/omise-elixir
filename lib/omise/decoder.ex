defmodule Omise.Decoder do
  @moduledoc false

  @versions %{
    "V20140727" => ~w(
      account
      balance
      bank_account
      card
      chain
      charge
      customer
      dispute
      document
      event
      forex
      link
      list
      occurrence
      receipt
      recipient
      refund
      schedule
      search
      token
      transaction
      transfer
    ),

    "V20151117" => ~w(
      charge
    ),
  }

  def decode(data, options \\ [])
  def decode(%{"object" => object} = map, options) do
    module = convert_to_module(object, options[:version])
    Poison.Decode.decode(map, Keyword.merge(options, as: struct(module)))
  end
  def decode([%{"object" => object} | _] = list, options) do
    module = convert_to_module(object, options[:version])
    Poison.Decode.decode(list, Keyword.merge(options, as: [struct(module)]))
  end
  def decode(data, _options) do
    data
  end

  defp convert_to_module(object, nil), do: Module.concat([Omise, Macro.camelize(object)])
  defp convert_to_module(object, given_version) do
    {resolved_version, _} = @versions
                            |> Enum.sort(&(&1 >= &2))
                            |> Enum.find(fn({version, objects}) -> version <= given_version && object in objects end)

    Module.concat([Omise, resolved_version, Macro.camelize(object)])
  end
end
