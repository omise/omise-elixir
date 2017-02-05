defmodule Omise.EventTest do
  use ExUnit.Case
  import TestHelper

  @event_id "evnt_test_52cin5n9bb6lytxduh9"

  test "list all events" do
    with_mock_request "events-get", fn ->
      {:ok, list} = Omise.Event.list

      assert %Omise.List{data: events} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each events, fn(event) ->
        assert %Omise.Event{data: data} = event
        assert event.object == "event"
        assert is_map(data)
      end
    end
  end

  test "retrieve an event" do
    with_mock_request "events/#{@event_id}-get", fn ->
      {:ok, event} = Omise.Event.retrieve(@event_id)

      assert %Omise.Event{} = event
      assert event.object == "event"
      assert event.id
      assert is_boolean(event.livemode)
      assert event.location
      assert event.key
      assert is_map(event.data)
    end
  end
end
