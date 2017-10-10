defmodule Omise.TestCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Mock
      import Omise.TestCase
    end
  end

  defmacro it(expression, options, do: block) do
    path = Keyword.fetch!(options, :via)
    body = if String.contains?(path, "tokens") do
             File.read!("./test/fixtures/vault.omise.co/#{path}.json")
           else
             File.read!("./test/fixtures/api.omise.co/#{path}.json")
           end
    headers = [{"Omise-Version", "2015-11-17"}]

    quote do
      test_with_mock unquote(expression), HTTPoison, [request!: fn(_, _, _, _, _)  -> %HTTPoison.Response{body: unquote(body), headers: unquote(headers)} end],
        do: unquote(block)
    end
  end
end
