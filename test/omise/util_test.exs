defmodule Omise.UtilTest do
  use ExUnit.Case

  test "that into_keyword function can transform Map to Keyword" do
    map01 = %{email: "teerawat@test.com"}
    map02 = %{email: "teerawat@test.com", description: "test description"}
    map03 = %{c: 3, a: 1, b: 2}

    assert Omise.Util.into_keyword(map01) == [email: "teerawat@test.com"]
    assert Omise.Util.into_keyword(map02) == [description: "test description", email: "teerawat@test.com"]
    assert Omise.Util.into_keyword(map03) == [a: 1, b: 2, c: 3]
  end
end
