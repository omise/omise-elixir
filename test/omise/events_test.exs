defmodule Omise.EventsTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all events" do
    with_mock_request "events_list", fn ->
      {:ok, events} = Omise.Events.list

      assert is_list(events[:data])
    end
  end

  test "retrieve an event" do
    with_mock_request "event_retrieve", fn ->
      {:ok, event} = Omise.Events.retrieve("evnt_test_52om9d14y2bl9c2sgy8")

      assert event.id
      assert event.location
      assert event.key
      assert event.created
      assert event.data
    end
  end
end
