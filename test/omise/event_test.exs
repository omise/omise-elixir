defmodule Omise.EventTest do
  use Omise.TestCase

  it "can list all events", via: "events-get" do
    {:ok, list} = Omise.Event.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "event"))
  end

  it "can retrieve the event", via: "events/evnt_test_52cin5n9bb6lytxduh9-get" do
    {:ok, event} = Omise.Event.retrieve("evnt_test_52cin5n9bb6lytxduh9")

    assert event.object == "event"
    assert event.id == "evnt_test_52cin5n9bb6lytxduh9"
  end
end
