defmodule Omise.AccountTest do
  use Omise.TestCase

  alias Omise.Account

  setup_all do: set_fixture_dir("account")

  describe "retrieve/1" do
    test "retrieves account" do
      use_cassette "retrieve_account" do
        assert Account.retrieve() ==
                 {:ok,
                  %Omise.Account{
                    created: "2016-08-31T05:22:15Z",
                    currency: "thb",
                    email: "m.mantastyle@gmail.com",
                    id: "acct_51n45m422m7yrgri706",
                    livemode: false,
                    location: "/account",
                    object: "account",
                    supported_currencies: ["thb", "jpy", "usd", "eur", "gbp", "sgd"]
                  }}
      end
    end
  end
end
