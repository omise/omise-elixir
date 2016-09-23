defmodule Omise.SearchTest do
  use ExUnit.Case

  alias Omise.Search

  test "search with invalid scope" do
    invalid_scopes = ["transfer", "elixir", nil]
    Enum.each invalid_scopes, fn(scope) ->
      assert_raise FunctionClauseError, fn ->
        Search.execute(scope, [])
      end
    end
  end
end
