defmodule Omise.BalanceTest do
  use Omise.TestCase

  alias Omise.Balance

  setup_all do: set_fixture_dir("balance")

  describe "retrieve/1" do
    test "retrieves balance" do
      use_cassette "retrieve_balance" do
        assert Balance.retrieve() ==
                 {:ok, %Omise.Balance{
                   currency: "thb",
                   livemode: false,
                   location: "/balance",
                   object: "balance",
                   reserve_amount: 0,
                   available: 393_336_607,
                   total: 393_336_607
                 }}
      end
    end
  end
end
