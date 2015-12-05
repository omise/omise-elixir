defmodule Omise.EventsTest do
  use ExUnit.Case, async: false

  test "list all events" do
    {:ok, events} = Omise.Events.list

    assert is_list(events)
  end
end
