defmodule OmiseTest do
  use ExUnit.Case, async: false

  test "omise version" do
    assert Omise.Mixfile.project[:version] == Omise.Version.omise_version
  end
end
