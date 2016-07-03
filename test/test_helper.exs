ExUnit.start

defmodule TestHelper do
  use ExUnit.Case
  import Mock

  def with_mock_request(path, fun) do
    with_mock HTTPoison, [request!: fn(_, _, _, _, _)  -> mock_request(path) end] do
      fun.()
    end
  end

  defp mock_request(path) do
    response =
      if String.starts_with?(path, "tokens") do
        File.read!("./test/fixtures/vault.omise.co/#{path}.json")
      else
        File.read!("./test/fixtures/api.omise.co/#{path}.json")
      end
    %HTTPoison.Response{body: response}
  end
end
