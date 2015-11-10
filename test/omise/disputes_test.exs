defmodule Omise.DisputesTest do
  use ExUnit.Case, async: false

  test "list all disputes" do
    {:ok, disputes} = Omise.Disputes.list

    assert is_list(disputes)
  end
end
