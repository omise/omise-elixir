defmodule Omise.EventTest do
  use Omise.TestCase

  alias Omise.Event

  setup_all do: set_fixture_dir("event")

  describe "list/2" do
    test "lists all events" do
      use_cassette "list_events" do
        assert Event.list(limit: 2, order: "reverse_chronological") ==
                 {:ok, %Omise.List{
                   data: [
                     %Omise.Event{
                       created: "2017-11-04T12:24:35+00:00",
                       data: %Omise.Charge{
                         amount: 49900,
                         authorize_uri: nil,
                         authorized: true,
                         capture: true,
                         captured: nil,
                         card: %Omise.Card{
                           bank: "",
                           brand: "Visa",
                           city: "Bangkok",
                           country: "us",
                           created: "2017-11-04T12:23:59Z",
                           deleted: false,
                           expiration_month: 10,
                           expiration_year: 2019,
                           financing: "",
                           fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                           id: "card_test_59uuezoxvvgtvyeqppx",
                           last_digits: "4242",
                           livemode: false,
                           location: nil,
                           name: "John Doe",
                           object: "card",
                           postal_code: "10320",
                           security_code_check: true
                         },
                         created: "2017-11-04T12:24:34Z",
                         currency: "thb",
                         customer: nil,
                         description: nil,
                         dispute: nil,
                         failure_code: nil,
                         failure_message: nil,
                         id: "chrg_test_59uuf77h7is4o1rsztm",
                         installment_terms: nil,
                         ip: nil,
                         livemode: false,
                         location: "/charges/chrg_test_59uuf77h7is4o1rsztm",
                         metadata: %{},
                         object: "charge",
                         offline: nil,
                         offsite: nil,
                         paid: true,
                         reference: nil,
                         refunded: 0,
                         refunds: %Omise.List{
                           data: [],
                           from: "1970-01-01T00:00:00Z",
                           limit: 20,
                           location: "/charges/chrg_test_59uuf77h7is4o1rsztm/refunds",
                           object: "list",
                           offset: 0,
                           order: nil,
                           to: "2017-11-04T12:24:35Z",
                           total: 0
                         },
                         return_uri: nil,
                         reversed: false,
                         source_of_fund: nil,
                         status: "successful",
                         transaction: "trxn_test_59uuf7a0o272na5lg9f"
                       },
                       id: "evnt_test_59uuf7adj2rrisn5u9l",
                       key: "charge.create",
                       livemode: false,
                       location: "/events/evnt_test_59uuf7adj2rrisn5u9l",
                       object: "event"
                     },
                     %Omise.Event{
                       created: "2017-11-04T19:12:35+07:00",
                       data: %Omise.Dispute{
                         amount: 50000,
                         charge: "chrg_test_59usep2shcycq9vrn70",
                         closed_at: nil,
                         created: "2017-11-04T19:12:35+07:00",
                         currency: "thb",
                         documents: %Omise.List{
                           data: [],
                           from: "1970-01-01T07:00:00+07:00",
                           limit: 20,
                           location: "/disputes/dspt_test_59uuaz72tx6inasbfuj/documents",
                           object: "list",
                           offset: 0,
                           order: nil,
                           to: "2017-11-04T19:12:35+07:00",
                           total: 0
                         },
                         id: "dspt_test_59uuaz72tx6inasbfuj",
                         livemode: false,
                         location: "/disputes/dspt_test_59uuaz72tx6inasbfuj",
                         message: nil,
                         object: "dispute",
                         reason_code: "goods_or_services_not_provided",
                         reason_message: "Services not provided or Merchandise not received",
                         status: "open",
                         transaction: "trxn_test_59uuaz7cd582g1ynune"
                       },
                       id: "evnt_test_59uuaz7nvrjsq35qh5c",
                       key: "dispute.create",
                       livemode: false,
                       location: "/events/evnt_test_59uuaz7nvrjsq35qh5c",
                       object: "event"
                     }
                   ],
                   from: "1970-01-01T00:00:00Z",
                   limit: 2,
                   location: "/events",
                   object: "list",
                   offset: 0,
                   order: "reverse_chronological",
                   to: "2017-11-04T12:25:42Z",
                   total: 2501
                 }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves event" do
      use_cassette "retrieve_event" do
        assert Event.retrieve("evnt_test_59uuaz7nvrjsq35qh5c") ==
                 {:ok, %Omise.Event{
                   created: "2017-11-04T19:12:35+07:00",
                   data: %Omise.Dispute{
                     amount: 50000,
                     charge: "chrg_test_59usep2shcycq9vrn70",
                     closed_at: nil,
                     created: "2017-11-04T19:12:35+07:00",
                     currency: "thb",
                     documents: %Omise.List{
                       data: [],
                       from: "1970-01-01T07:00:00+07:00",
                       limit: 20,
                       location: "/disputes/dspt_test_59uuaz72tx6inasbfuj/documents",
                       object: "list",
                       offset: 0,
                       order: nil,
                       to: "2017-11-04T19:12:35+07:00",
                       total: 0
                     },
                     id: "dspt_test_59uuaz72tx6inasbfuj",
                     livemode: false,
                     location: "/disputes/dspt_test_59uuaz72tx6inasbfuj",
                     message: nil,
                     object: "dispute",
                     reason_code: "goods_or_services_not_provided",
                     reason_message: "Services not provided or Merchandise not received",
                     status: "open",
                     transaction: "trxn_test_59uuaz7cd582g1ynune"
                   },
                   id: "evnt_test_59uuaz7nvrjsq35qh5c",
                   key: "dispute.create",
                   livemode: false,
                   location: "/events/evnt_test_59uuaz7nvrjsq35qh5c",
                   object: "event"
                 }}
      end
    end
  end
end
