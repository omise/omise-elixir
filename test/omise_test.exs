defmodule OmiseTest do
  use ExUnit.Case, async: true

  test "that secret_key can be retrieved" do
    assert Omise.secret_key != nil
  end

  test "that public_key can be retrieved" do
    assert Omise.public_key != nil
  end
end
