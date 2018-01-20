defmodule Omise.LinkTest do
  use Omise.TestCase

  alias Omise.Link

  setup_all do: set_fixture_dir("link")

  describe "list/2" do
    test "lists links" do
      use_cassette "list_links" do
        assert Link.list(limit: 1) ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Link{
                        amount: 100_000,
                        charges: %Omise.List{
                          data: [
                            %Omise.Charge{
                              amount: 100_000,
                              authorize_uri: "https://api.omise.co/payments/paym_test_55s7qs1dsrb7j9sgkh7/authorize",
                              authorized: true,
                              capture: true,
                              captured: nil,
                              card: %Omise.Card{
                                bank: "",
                                brand: "Visa",
                                city: nil,
                                country: "us",
                                created: "2016-10-25T15:08:44Z",
                                deleted: false,
                                expiration_month: 6,
                                expiration_year: 2021,
                                financing: "",
                                fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                                id: "card_test_55s7qrs5i8onwoavhtq",
                                last_digits: "4242",
                                livemode: false,
                                location: nil,
                                name: "manta",
                                object: "card",
                                postal_code: nil,
                                security_code_check: true
                              },
                              created: "2016-10-25T15:08:45Z",
                              currency: "thb",
                              customer: nil,
                              description: "Elixir book\n\nThis book is awesome!",
                              dispute: nil,
                              failure_code: nil,
                              failure_message: nil,
                              id: "chrg_test_55s7qs0zuwllp0pbvq1",
                              installment_terms: nil,
                              ip: "171.97.98.142",
                              livemode: false,
                              location: "/charges/chrg_test_55s7qs0zuwllp0pbvq1",
                              metadata: %{},
                              object: "charge",
                              offline: nil,
                              offsite: nil,
                              paid: true,
                              reference: "paym_test_55s7qs1dsrb7j9sgkh7",
                              refunded: 0,
                              refunds: %Omise.List{
                                data: [],
                                from: "1970-01-01T00:00:00Z",
                                limit: 20,
                                location: "/charges/chrg_test_55s7qs0zuwllp0pbvq1/refunds",
                                object: "list",
                                offset: 0,
                                order: nil,
                                to: "2017-11-04T12:38:35Z",
                                total: 0
                              },
                              return_uri: "https://link.omise.co/60CA5DF4/complete",
                              reversed: false,
                              source: nil,
                              source_of_fund: nil,
                              status: "successful",
                              transaction: "trxn_test_55s7qs2rv3mriqoi64u"
                            },
                            %Omise.Charge{
                              amount: 100_000,
                              authorize_uri: "https://api.omise.co/payments/paym_test_55s7qkofno5lgyhfn61/authorize",
                              authorized: true,
                              capture: true,
                              captured: nil,
                              card: %Omise.Card{
                                bank: "JPMORGAN CHASE BANK, N.A.",
                                brand: "Visa",
                                city: nil,
                                country: "us",
                                created: "2016-10-25T15:08:09Z",
                                deleted: false,
                                expiration_month: 3,
                                expiration_year: 2020,
                                financing: "",
                                fingerprint: "BGCSfmEVsDHvgi7OuFC7pWEHbZzkYSOEVZQFpgoIXJ0=",
                                id: "card_test_55s7qkf56w4xi21qthp",
                                last_digits: "1111",
                                livemode: false,
                                location: nil,
                                name: "teerawat",
                                object: "card",
                                postal_code: nil,
                                security_code_check: true
                              },
                              created: "2016-10-25T15:08:10Z",
                              currency: "thb",
                              customer: nil,
                              description: "Elixir book\n\nThis book is awesome!",
                              dispute: nil,
                              failure_code: nil,
                              failure_message: nil,
                              id: "chrg_test_55s7qko16ogz9fhie7l",
                              installment_terms: nil,
                              ip: "171.97.98.142",
                              livemode: false,
                              location: "/charges/chrg_test_55s7qko16ogz9fhie7l",
                              metadata: %{},
                              object: "charge",
                              offline: nil,
                              offsite: nil,
                              paid: true,
                              reference: "paym_test_55s7qkofno5lgyhfn61",
                              refunded: 0,
                              refunds: %Omise.List{
                                data: [],
                                from: "1970-01-01T00:00:00Z",
                                limit: 20,
                                location: "/charges/chrg_test_55s7qko16ogz9fhie7l/refunds",
                                object: "list",
                                offset: 0,
                                order: nil,
                                to: "2017-11-04T12:38:35Z",
                                total: 0
                              },
                              return_uri: "https://link.omise.co/60CA5DF4/complete",
                              reversed: false,
                              source: nil,
                              source_of_fund: nil,
                              status: "successful",
                              transaction: "trxn_test_55s7qkpxw5933arm35h"
                            }
                          ],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/links/link_test_55s7o45gtn5nic6ycv7/charges",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T12:38:35Z",
                          total: 2
                        },
                        created: "2016-10-25T15:01:11Z",
                        currency: "thb",
                        description: "This book is awesome!",
                        id: "link_test_55s7o45gtn5nic6ycv7",
                        livemode: false,
                        location: "/links/link_test_55s7o45gtn5nic6ycv7",
                        multiple: true,
                        object: "link",
                        payment_uri: "https://link.omise.co/60CA5DF4",
                        title: "Elixir book",
                        used: false
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 1,
                    location: "/links",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T12:38:35Z",
                    total: 15
                  }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves link" do
      use_cassette "retrieve_link" do
        assert Link.retrieve("link_test_59ur6gqhjjc8u4s29eq") ==
                 {:ok,
                  %Omise.Link{
                    amount: 20000,
                    charges: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/links/link_test_59ur6gqhjjc8u4s29eq/charges",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T12:40:14Z",
                      total: 0
                    },
                    created: "2017-11-04T06:52:57Z",
                    currency: "thb",
                    description: "Nice song",
                    id: "link_test_59ur6gqhjjc8u4s29eq",
                    livemode: false,
                    location: "/links/link_test_59ur6gqhjjc8u4s29eq",
                    multiple: true,
                    object: "link",
                    payment_uri: "https://link.omise.co/7D900F21",
                    title: "Robbers - The 1975",
                    used: false
                  }}
      end
    end
  end

  describe "create/2" do
    test "creates link" do
      use_cassette "create_link" do
        assert Link.create(
                 amount: 59900,
                 currency: "thb",
                 title: "Big fish",
                 description: "Great old movie",
                 multiple: true
               ) ==
                 {:ok,
                  %Omise.Link{
                    amount: 59900,
                    charges: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/links/link_test_59uuloykfosnx1a944s/charges",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T12:43:01Z",
                      total: 0
                    },
                    created: "2017-11-04T12:43:01Z",
                    currency: "thb",
                    description: "Great old movie",
                    id: "link_test_59uuloykfosnx1a944s",
                    livemode: false,
                    location: "/links/link_test_59uuloykfosnx1a944s",
                    multiple: true,
                    object: "link",
                    payment_uri: "https://link.omise.co/F89392D0",
                    title: "Big fish",
                    used: false
                  }}
      end
    end
  end
end
