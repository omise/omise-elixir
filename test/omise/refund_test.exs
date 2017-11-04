defmodule Omise.RefundTest do
  use Omise.TestCase

  alias Omise.Refund

  setup_all do: set_fixture_dir("refund")

  describe "list/2" do
    test "lists all refunds" do
      use_cassette "list_refunds" do
        assert Refund.list(offset: 2, limit: 2) ==
                 {:ok, %Omise.List{
                   data: [
                     %Omise.Refund{
                       amount: 10000,
                       charge: "chrg_test_59hswv1numidf7u4lhl",
                       created: "2017-10-02T05:43:18Z",
                       currency: "thb",
                       id: "rfnd_test_59htu09j851vhv4lc13",
                       location: "/charges/chrg_test_59hswv1numidf7u4lhl/refunds/rfnd_test_59htu09j851vhv4lc13",
                       object: "refund",
                       transaction: "trxn_test_59htu09pjfcpghgeyw4",
                       voided: false
                     },
                     %Omise.Refund{
                       amount: 5000,
                       charge: "chrg_test_59k3ua8kdrnhi704oaw",
                       created: "2017-10-08T05:15:38Z",
                       currency: "thb",
                       id: "rfnd_test_59k61pjd83lweny6740",
                       location: "/charges/chrg_test_59k3ua8kdrnhi704oaw/refunds/rfnd_test_59k61pjd83lweny6740",
                       object: "refund",
                       transaction: "trxn_test_59k61pjk3fyh3yxb4qy",
                       voided: false
                     }
                   ],
                   from: "1970-01-01T00:00:00Z",
                   limit: 2,
                   location: "/refunds",
                   object: "list",
                   offset: 2,
                   order: "chronological",
                   to: "2017-11-04T13:23:08Z",
                   total: 6
                 }}
      end
    end
  end
end
