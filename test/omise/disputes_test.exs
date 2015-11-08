defmodule Omise.DisputesTest do
  use ExUnit.Case, async: true

  test "list all disputes" do
    {:ok, disputes} = Omise.Disputes.list

    assert is_list(disputes.data)
  end
end
