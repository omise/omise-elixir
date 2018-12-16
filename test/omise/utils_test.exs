defmodule Omise.UtilsTest do
  use ExUnit.Case, async: true

  alias Omise.Utils

  test "normalizes search query params" do
    test_cases = [
      %{
        input: [query: "foo"],
        output: [query: "foo"]
      },
      %{
        input: [query: "foo", foo: "bar", filter: [hello: "world"]],
        output: [query: "foo"]
      },
      %{
        input: [],
        output: []
      },
      %{
        input: [query: "foo", filters: []],
        output: [query: "foo"]
      },
      %{
        input: [query: "foo", filters: [foo: "bar"]],
        output: [query: "foo", "filters[foo]": "bar"]
      },
      %{
        input: [filters: [foo: "bar"]],
        output: ["filters[foo]": "bar"]
      }
    ]

    Enum.each(test_cases, fn %{input: input, output: expected_output} ->
      assert Utils.normalize_search_params(input) == expected_output
    end)
  end
end
