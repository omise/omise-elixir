defmodule Omise.CapabilityTest do
  use Omise.TestCase, async: true

  alias Omise.Capability

  setup do: set_fixture_dir("capability")

  describe "retrieve/0" do
    test "retrieve capability" do
      use_cassette "retrieve_capability" do
        assert Capability.retrieve() ==
                 {:ok,
                  %Omise.Capability{
                    banks: [
                      "test",
                      "bbl",
                      "kbank",
                      "rbs",
                      "ktb",
                      "jpm",
                      "mufg",
                      "tmb",
                      "scb",
                      "citi",
                      "smbc",
                      "sc",
                      "cimb",
                      "uob",
                      "bay",
                      "mega",
                      "boa",
                      "cacib",
                      "gsb",
                      "hsbc",
                      "db",
                      "ghb",
                      "baac",
                      "mb",
                      "bnp",
                      "tbank",
                      "ibank",
                      "tisco",
                      "kk",
                      "icbc",
                      "tcrb",
                      "lhb"
                    ],
                    country: "TH",
                    location: "/capability",
                    object: "capability",
                    payment_methods: [
                      %Omise.PaymentMethod{
                        card_brands: ["JCB", "Visa", "MasterCard"],
                        currencies: ["THB", "JPY", "USD", "EUR", "GBP", "SGD", "AUD", "CHF", "CNY", "DKK", "HKD"],
                        installment_terms: nil,
                        name: "card",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "internet_banking_bay",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "internet_banking_ktb",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "internet_banking_scb",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "internet_banking_bbl",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "alipay",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: [3, 4, 6, 9, 10],
                        name: "installment_bay",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: [3, 4, 6, 10],
                        name: "installment_kbank",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: [3, 4, 5, 6, 7, 8, 9, 10],
                        name: "installment_ktc",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: [4, 6, 8, 9, 10],
                        name: "installment_bbl",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: [3, 4, 6, 9, 10, 12, 18, 24, 36],
                        name: "installment_first_choice",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "bill_payment_tesco_lotus",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "barcode_alipay",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "promptpay",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "mobile_banking_scb",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "truemoney",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: [3, 4, 6, 9, 10],
                        name: "installment_scb",
                        object: "payment_method"
                      },
                      %Omise.PaymentMethod{
                        card_brands: nil,
                        currencies: ["THB"],
                        installment_terms: nil,
                        name: "points_citi",
                        object: "payment_method"
                      }
                    ],
                    zero_interest_installments: false
                  }}
      end
    end
  end
end
