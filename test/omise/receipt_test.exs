defmodule Omise.ReceiptTest do
  use Omise.TestCase

  alias Omise.Receipt

  setup_all do: set_fixture_dir("receipt")

  describe "list/2" do
    test "lists all receipts" do
      use_cassette "list_receipts" do
        assert Receipt.list(from: "2017-11-03", to: "2017-11-03") ==
                 {:ok, %Omise.List{
                   data: [
                     %Omise.Receipt{
                       charge_fee: 4_548_000,
                       company_address:
                         "1448/4, J2 Building, Soi Ladprao 87\r\n(Chandrasuk), Praditmanutham Road,\r\nKlongchan, Bangkapi, Bangkok, 10240",
                       company_name: "Omise Company Limited",
                       company_tax_id: "0105556091152",
                       credit_note: false,
                       currency: "thb",
                       customer_address: "212\n12\nBangkok 10400",
                       customer_email: "ton@omise.co",
                       customer_name: "Teerawat Lamanchart",
                       customer_statement_name: "",
                       customer_tax_id: "",
                       date: "2017-11-03T16:59:59Z",
                       id: "rcpt_59unfpvug2yllbnkphv",
                       location: "/receipts/rcpt_59unfpvug2yllbnkphv",
                       number: "OMTH201711030001",
                       object: "receipt",
                       subtotal: 4_548_000,
                       total: 4_866_360,
                       transfer_fee: 0,
                       vat: 318_360,
                       voided_fee: 0,
                       wht: 0
                     }
                   ],
                   from: "2017-11-03T00:00:00Z",
                   limit: 20,
                   location: "/receipts",
                   object: "list",
                   offset: 0,
                   order: "chronological",
                   to: "2017-11-03T23:59:59Z",
                   total: 1
                 }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves receipt" do
      use_cassette "retrieve_receipt" do
        assert Receipt.retrieve("rcpt_59unfpvug2yllbnkphv") ==
                 {:ok, %Omise.Receipt{
                   charge_fee: 4_548_000,
                   company_address:
                     "1448/4, J2 Building, Soi Ladprao 87\r\n(Chandrasuk), Praditmanutham Road,\r\nKlongchan, Bangkapi, Bangkok, 10240",
                   company_name: "Omise Company Limited",
                   company_tax_id: "0105556091152",
                   credit_note: false,
                   currency: "thb",
                   customer_address: "212\n12\nBangkok 10400",
                   customer_email: "ton@omise.co",
                   customer_name: "Teerawat Lamanchart",
                   customer_statement_name: "",
                   customer_tax_id: "",
                   date: "2017-11-03T16:59:59Z",
                   id: "rcpt_59unfpvug2yllbnkphv",
                   location: "/receipts/rcpt_59unfpvug2yllbnkphv",
                   number: "OMTH201711030001",
                   object: "receipt",
                   subtotal: 4_548_000,
                   total: 4_866_360,
                   transfer_fee: 0,
                   vat: 318_360,
                   voided_fee: 0,
                   wht: 0
                 }}
      end
    end
  end
end
