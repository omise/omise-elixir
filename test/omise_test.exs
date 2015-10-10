defmodule OmiseTest do
  use ExUnit.Case

  test "that secret_key can be retrieved" do
    assert Application.get_env(:omise, :secret_key) != nil
  end
end
