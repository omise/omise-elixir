defmodule Omise.OccurrenceTest do
  use Omise.TestCase

  it "can retrieve the occurrence", via: "occurrences/occu_test_584yqgivyi2p1g828pl-get" do
    {:ok, occurrence} = Omise.Occurrence.retrieve("occu_test_584yqgivyi2p1g828pl")

    assert occurrence.object == "occurrence"
    assert occurrence.id == "occu_test_584yqgivyi2p1g828pl"
  end
end
