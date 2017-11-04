defmodule Omise.TransactionTest do
  use Omise.TestCase

  alias Omise.Transaction

  setup_all do: set_fixture_dir("transaction")

  describe "list/2" do
    test "lists all transactions" do
      use_cassette "list_transactions" do
        assert Transaction.list(from: "2017-11-01", to: "2017-11-03") ==
                 {:ok, %Omise.List{
                   data: [
                     %Omise.Transaction{
                       amount: 96094,
                       created: "2017-11-01T01:30:01Z",
                       currency: "thb",
                       id: "trxn_test_59ths2avj935oi6d9al",
                       location: "/transactions/trxn_test_59ths2avj935oi6d9al",
                       object: "transaction",
                       source: "chrg_test_59ths24kvjhxqmnb6i9",
                       transferable: "2017-11-01T01:30:01Z",
                       type: "credit"
                     },
                     %Omise.Transaction{
                       amount: 19123,
                       created: "2017-11-01T01:30:02Z",
                       currency: "thb",
                       id: "trxn_test_59ths2gwn9c12z0j1xo",
                       location: "/transactions/trxn_test_59ths2gwn9c12z0j1xo",
                       object: "transaction",
                       source: "chrg_test_59ths24elfiwc9dag2p",
                       transferable: "2017-11-01T01:30:02Z",
                       type: "credit"
                     },
                     %Omise.Transaction{
                       amount: 19123,
                       created: "2017-11-02T01:30:03Z",
                       currency: "thb",
                       id: "trxn_test_59tvuzadrid9tlf3pnd",
                       location: "/transactions/trxn_test_59tvuzadrid9tlf3pnd",
                       object: "transaction",
                       source: "chrg_test_59tvuysd2mkvbtpodvs",
                       transferable: "2017-11-02T01:30:03Z",
                       type: "credit"
                     }
                   ],
                   from: "2017-11-01T00:00:00Z",
                   limit: 20,
                   location: "/transactions",
                   object: "list",
                   offset: 0,
                   order: "chronological",
                   to: "2017-11-03T00:00:00Z",
                   total: 3
                 }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves transaction" do
      use_cassette "retrieve_transaction" do
        assert Transaction.retrieve("trxn_test_59tvuzadrid9tlf3pnd") ==
                 {:ok, %Omise.Transaction{
                   amount: 19123,
                   created: "2017-11-02T01:30:03Z",
                   currency: "thb",
                   id: "trxn_test_59tvuzadrid9tlf3pnd",
                   location: "/transactions/trxn_test_59tvuzadrid9tlf3pnd",
                   object: "transaction",
                   source: "chrg_test_59tvuysd2mkvbtpodvs",
                   transferable: "2017-11-02T01:30:03Z",
                   type: "credit"
                 }}
      end
    end
  end
end
