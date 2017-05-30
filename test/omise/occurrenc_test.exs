defmodule Omise.OccurrenceTest do
  use ExUnit.Case
  import TestHelper

  @occurrence_id "occu_test_584yqgivyi2p1g828pl"

  test "retrieve an occurrence" do
    with_mock_request "occurrences/#{@occurrence_id}-get", fn ->
      {:ok, occurrence} = Omise.Occurrence.retrieve(@occurrence_id)

      assert %Omise.Occurrence{} = occurrence
      assert occurrence.object == "occurrence"
      assert occurrence.id == @occurrence_id
      assert occurrence.location
      assert occurrence.schedule
      assert occurrence.schedule_date
      assert occurrence.processed_at
      assert occurrence.status
      assert occurrence.result
      assert occurrence.created
    end
  end
end
