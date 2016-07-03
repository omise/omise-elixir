defmodule OmiseTest do
  use ExUnit.Case, async: false

  test "omise version" do
    assert Omise.Mixfile.project[:version] == Omise.Version.project_version
  end
end
