defmodule Omise.ForexTest do
  use Omise.TestCase, async: true

  alias Omise.Forex

  setup do: set_fixture_dir("forex")

  describe "retrieve/2" do
    test "retrieves forex" do
      use_cassette "retrieve_forex" do
        assert Forex.retrieve("usd") ==
                 {:ok,
                  %Omise.Forex{
                    from: "usd",
                    location: "/forex/usd",
                    object: "forex",
                    rate: 31.895433500000003,
                    to: "thb"
                  }}
      end
    end
  end
end
