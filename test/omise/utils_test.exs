defmodule Omise.UtilsTest do
  use ExUnit.Case

  alias Omise.Utils

  test "encode params to json format" do
    test_cases = [
      %{
        input:  [amount: 100],
        output: "{\"amount\":100}"
      },

      %{
        input:  [],
        output: "{}"
      },

      %{
        input:  [id: 1, name: "elixir"],
        output: "{\"name\":\"elixir\",\"id\":1}"
      },

      %{
        input:  [id: 1, bank_account: [brand: "bbl", number: "9999999999"]],
        output: "{\"id\":1,\"bank_account\":{\"number\":\"9999999999\",\"brand\":\"bbl\"}}"
      }
    ]

    Enum.each test_cases, fn(%{input: input, output: expected_output}) ->
      assert Utils.encode_to_json(input) == expected_output
    end
  end
end
