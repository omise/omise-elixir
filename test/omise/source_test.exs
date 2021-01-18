defmodule Omise.SourceTest do
  use Omise.TestCase, async: true

  alias Omise.Source

  setup do: set_fixture_dir("source")

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

    test "retrieve source" do
      use_cassette "retrieve_source" do
        assert Source.retrieve("src_test_5mkpd5uqxnnqw4p411c") ==
                 {:ok,
                  %Omise.Source{
                    amount: 1_000_000,
                    barcode: nil,
                    charge_status: "pending",
                    created: nil,
                    currency: "THB",
                    flow: "offline",
                    id: "src_test_5mkpd5uqxnnqw4p411c",
                    installment_term: nil,
                    livemode: false,
                    location: "/sources/src_test_5mkpd5uqxnnqw4p411c",
                    mobile_number: nil,
                    name: nil,
                    object: "source",
                    phone_number: nil,
                    references: nil,
                    scannable_code: %Omise.Barcode{
                      image: %Omise.Document{
                        deleted: false,
                        download_uri:
                          "https://api.omise.co/charges/chrg_test_5mkpd5wcoazpu1xde6c/documents/docu_test_5mkpd5xuko50s1rv98d/downloads/9D53860BFB89AC18",
                        filename: "qrcode.png",
                        id: "docu_test_5mkpd5xuko50s1rv98d",
                        livemode: false,
                        location: "/charges/chrg_test_5mkpd5wcoazpu1xde6c/documents/docu_test_5mkpd5xuko50s1rv98d",
                        object: "document"
                      },
                      object: "barcode",
                      type: "qr"
                    },
                    store_id: nil,
                    store_name: nil,
                    terminal_id: nil,
                    type: "promptpay",
                    zero_interest_installments: nil
                  }}
      end
    end
  end
end
