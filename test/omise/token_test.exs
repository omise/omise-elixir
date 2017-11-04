defmodule Omise.TokenTest do
  use Omise.TestCase

  alias Omise.Token

  setup_all do: set_fixture_dir("token")

  describe "create/2" do
    test "creates token" do
      use_cassette "create_token" do
        assert Token.create(
                 card: [
                   name: "John Doe",
                   number: 4_242_424_242_424_242,
                   security_code: 123,
                   expiration_month: 10,
                   expiration_year: 2025
                 ]
               ) ==
                 {:ok, %Omise.Token{
                   card: %Omise.Card{
                     bank: "",
                     brand: "Visa",
                     city: nil,
                     country: "us",
                     created: "2017-11-04T14:11:32Z",
                     deleted: false,
                     expiration_month: 10,
                     expiration_year: 2025,
                     financing: "",
                     fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                     id: "card_test_59uvgulszd6ybf9mlet",
                     last_digits: "4242",
                     livemode: false,
                     location: nil,
                     name: "John Doe",
                     object: "card",
                     postal_code: nil,
                     security_code_check: true
                   },
                   created: "2017-11-04T14:11:32Z",
                   id: "tokn_test_59uvguluact4trbfjbq",
                   livemode: false,
                   location: "https://vault.omise.co/tokens/tokn_test_59uvguluact4trbfjbq",
                   object: "token",
                   used: false
                 }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves token" do
      use_cassette "retrieve_token" do
        assert Token.retrieve("tokn_test_59uvguluact4trbfjbq") ==
                 {:ok, %Omise.Token{
                   card: %Omise.Card{
                     bank: "",
                     brand: "Visa",
                     city: nil,
                     country: "us",
                     created: "2017-11-04T14:11:32Z",
                     deleted: false,
                     expiration_month: 10,
                     expiration_year: 2025,
                     financing: "",
                     fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                     id: "card_test_59uvgulszd6ybf9mlet",
                     last_digits: "4242",
                     livemode: false,
                     location: nil,
                     name: "John Doe",
                     object: "card",
                     postal_code: nil,
                     security_code_check: true
                   },
                   created: "2017-11-04T14:11:32Z",
                   id: "tokn_test_59uvguluact4trbfjbq",
                   livemode: false,
                   location: "https://vault.omise.co/tokens/tokn_test_59uvguluact4trbfjbq",
                   object: "token",
                   used: false
                 }}
      end
    end
  end
end
