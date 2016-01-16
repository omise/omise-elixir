ExUnit.start

defmodule TestHelper do
  use ExUnit.Case, async: false

  import Mock

  def with_mock_request(path, fun) do
    with_mock Omise, mock_functions(path) do
      fun.()
    end
  end

  defp mock_functions(path) do
    [
      make_request: fn(_, _)        -> mock_request(path) end,
      make_request: fn(_, _, _)     -> mock_request(path) end,
      make_request: fn(_, _, _, _)  -> mock_request(path) end,
    ]
  end

  defp mock_request(path) do
    {:ok, response} = File.read("./test/fixtures/#{path}.json")
    Omise.Util.handle_response(%HTTPoison.Response{body: response})
  end
end
