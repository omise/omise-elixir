defmodule Omise.OccurrenceTest do
  use Omise.TestCase

  alias Omise.Occurrence

  setup_all do: set_fixture_dir("occurrence")

  describe "retrieve/2" do
    test "retrieves occurrence" do
      use_cassette "retrieve_occurrence" do
        assert Occurrence.retrieve("occu_test_59f0sida1ola85gf8pn") ==
                 {:ok, %Omise.Occurrence{
                   created: "2017-09-25T01:30:04Z",
                   id: "occu_test_59f0sida1ola85gf8pn",
                   livemode: false,
                   location: "/occurrences/occu_test_59f0sida1ola85gf8pn",
                   message: nil,
                   object: "occurrence",
                   processed_at: "2017-09-27T01:30:02Z",
                   result: "chrg_test_59fsyaz8f57p54998fg",
                   retry_date: nil,
                   schedule: "schd_test_584zb13ghl396u8va3q",
                   schedule_date: "2017-09-27",
                   status: "successful"
                 }}
      end
    end
  end
end
