defmodule Omise.SourceTest do
  use Omise.TestCase

  alias Omise.Source

  setup_all do: set_fixture_dir("source")

  describe "create/2" do
    test "creates source with valid params" do
      use_cassette "create_source_with_valid_params" do
        assert Source.create(
                 amount: 1000_00,
                 currency: "thb",
                 type: "bill_payment_tesco_lotus"
               ) ==
                 {:ok,
                  %Omise.Source{
                    amount: 100_000,
                    currency: "thb",
                    flow: "offline",
                    object: "source",
                    type: "bill_payment_tesco_lotus",
                    id: "src_test_59vbbpdylvrd15kn36u"
                  }}
      end
    end

    test "creates source with invalid amount" do
      use_cassette "create_source_with_invalid_amount" do
        assert Source.create(
                 amount: "invalid_amount",
                 currency: "thb",
                 type: "alipay"
               ) ==
                 {:error,
                  %Omise.Error{
                    code: "bad_request",
                    location: "https://www.omise.co/api-errors#bad-request",
                    message: "amount is not a number",
                    object: "error"
                  }}
      end
    end

    test "creates source with invalid currency" do
      use_cassette "create_source_with_invalid_currency" do
        assert Source.create(
                 amount: 1000_00,
                 currency: "invalid",
                 type: "internet_banking_bbl"
               ) ==
                 {:error,
                  %Omise.Error{
                    code: "bad_request",
                    location: "https://www.omise.co/api-errors#bad-request",
                    message: "currency is currently not supported",
                    object: "error"
                  }}
      end
    end

    test "creates source with invalid type" do
      use_cassette "create_source_with_invalid_type" do
        assert Source.create(
                 amount: 1000_00,
                 currency: "thb",
                 type: "invalid"
               ) ==
                 {:error,
                  %Omise.Error{
                    code: "bad_request",
                    location: "https://www.omise.co/api-errors#bad-request",
                    message: "type is currently not supported",
                    object: "error"
                  }}
      end
    end
  end
end
