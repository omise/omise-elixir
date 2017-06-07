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
        input:  [id: 1, name: "elixir", codes: [1, 2, 3]],
        output: "{\"name\":\"elixir\",\"id\":1,\"codes\":[1,2,3]}"
      },

      %{
        input:  [id: 1, name: "elixir", codes: []],
        output: "{\"name\":\"elixir\",\"id\":1,\"codes\":[]}"
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

  test "normalize search query params" do
    test_cases = [
      %{
        input:  [query: "foo"],
        output: [query: "foo"]
      },

      %{
        input:  [query: "foo", foo: "bar", filter: [hello: "world"]],
        output: [query: "foo"]
      },

      %{
        input:  [],
        output: []
      },

      %{
        input:  [query: "foo", filters: []],
        output: [query: "foo"]
      },

      %{
        input:  [query: "foo", filters: [foo: "bar"]],
        output: [query: "foo", "filters[foo]": "bar"]
      },

      %{
        input:  [filters: [foo: "bar"]],
        output: ["filters[foo]": "bar"]
      },
    ]

    Enum.each test_cases, fn(%{input: input, output: expected_output}) ->
      assert Utils.normalize_search_params(input) == expected_output
    end
  end
end
