defmodule Omise.CustomerTest do
  use Omise.TestCase, async: true

  alias Omise.Customer

  setup do: set_fixture_dir("customer")

  describe "list/2" do
    test "lists all customers" do
      use_cassette "list_customers" do
        assert Customer.list(limit: 2, order: "reverse_chronological") ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Customer{
                        cards: %Omise.List{
                          data: [
                            %Omise.Card{
                              bank: "",
                              brand: "Visa",
                              city: "Bangkok",
                              country: "us",
                              created: "2017-11-04T06:41:07Z",
                              deleted: false,
                              expiration_month: 10,
                              expiration_year: 2019,
                              financing: "",
                              fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                              id: "card_test_59ur2aloj4ofih2m8ct",
                              last_digits: "4242",
                              livemode: false,
                              location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4/cards/card_test_59ur2aloj4ofih2m8ct",
                              name: "John Doe",
                              object: "card",
                              postal_code: "10320",
                              security_code_check: true
                            }
                          ],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4/cards",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T11:17:20Z",
                          total: 1
                        },
                        created: "2017-11-04T06:42:11Z",
                        default_card: "card_test_59ur2aloj4ofih2m8ct",
                        deleted: false,
                        description: "Burnnnn",
                        email: "adele@gmail.com",
                        id: "cust_test_59ur2ob5ltcsl9vjwb4",
                        livemode: false,
                        location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4",
                        metadata: %{},
                        object: "customer"
                      },
                      %Omise.Customer{
                        cards: %Omise.List{
                          data: [],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/customers/cust_test_576rin7dke7hxnx8rxc/cards",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T11:17:20Z",
                          total: 0
                        },
                        created: "2017-03-03T20:52:00Z",
                        default_card: nil,
                        deleted: false,
                        description: "Another description",
                        email: "john.smith@example.com",
                        id: "cust_test_576rin7dke7hxnx8rxc",
                        livemode: false,
                        location: "/customers/cust_test_576rin7dke7hxnx8rxc",
                        metadata: %{},
                        object: "customer"
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 2,
                    location: "/customers",
                    object: "list",
                    offset: 0,
                    order: "reverse_chronological",
                    to: "2017-11-04T11:17:20Z",
                    total: 4
                  }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves customer" do
      use_cassette "retrieve_customer" do
        assert Customer.retrieve("cust_test_59ur2ob5ltcsl9vjwb4") ==
                 {:ok,
                  %Omise.Customer{
                    cards: %Omise.List{
                      data: [
                        %Omise.Card{
                          bank: "",
                          brand: "Visa",
                          city: "Bangkok",
                          country: "us",
                          created: "2017-11-04T06:41:07Z",
                          deleted: false,
                          expiration_month: 10,
                          expiration_year: 2019,
                          financing: "",
                          fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                          id: "card_test_59ur2aloj4ofih2m8ct",
                          last_digits: "4242",
                          livemode: false,
                          location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4/cards/card_test_59ur2aloj4ofih2m8ct",
                          name: "John Doe",
                          object: "card",
                          postal_code: "10320",
                          security_code_check: true
                        }
                      ],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4/cards",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T11:19:07Z",
                      total: 1
                    },
                    created: "2017-11-04T06:42:11Z",
                    default_card: "card_test_59ur2aloj4ofih2m8ct",
                    deleted: false,
                    description: "Burnnnn",
                    email: "adele@gmail.com",
                    id: "cust_test_59ur2ob5ltcsl9vjwb4",
                    livemode: false,
                    location: "/customers/cust_test_59ur2ob5ltcsl9vjwb4",
                    metadata: %{},
                    object: "customer"
                  }}
      end
    end
  end

  describe "create/2" do
    test "creates customer without card" do
      use_cassette "create_customer_without_card" do
        assert Customer.create(
                 email: "eleven@strangerthings.com",
                 description: "crazy little girl"
               ) ==
                 {:ok,
                  %Omise.Customer{
                    cards: %Omise.List{
                      data: [],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/customers/cust_test_59uttqwkl62x5wf9qys/cards",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T11:23:38Z",
                      total: 0
                    },
                    created: "2017-11-04T11:23:38Z",
                    default_card: nil,
                    deleted: false,
                    description: "crazy little girl",
                    email: "eleven@strangerthings.com",
                    id: "cust_test_59uttqwkl62x5wf9qys",
                    livemode: false,
                    location: "/customers/cust_test_59uttqwkl62x5wf9qys",
                    metadata: %{},
                    object: "customer"
                  }}
      end
    end

    test "creates customer with card" do
      use_cassette "create_customer_with_card" do
        assert Customer.create(
                 email: "mike@strangerthings.com",
                 description: "crazy little body",
                 card: "tokn_test_59utu4qomj72d0d1ta3"
               ) ==
                 {:ok,
                  %Omise.Customer{
                    cards: %Omise.List{
                      data: [
                        %Omise.Card{
                          bank: "",
                          brand: "Visa",
                          city: "Bangkok",
                          country: "us",
                          created: "2017-11-04T11:24:43Z",
                          deleted: false,
                          expiration_month: 10,
                          expiration_year: 2019,
                          financing: "",
                          fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                          id: "card_test_59utu4qnjvldpwg434g",
                          last_digits: "4242",
                          livemode: false,
                          location: "/customers/cust_test_59utuigfksnvsed9mi4/cards/card_test_59utu4qnjvldpwg434g",
                          name: "John Doe",
                          object: "card",
                          postal_code: "10320",
                          security_code_check: true
                        }
                      ],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/customers/cust_test_59utuigfksnvsed9mi4/cards",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T11:25:48Z",
                      total: 1
                    },
                    created: "2017-11-04T11:25:48Z",
                    default_card: "card_test_59utu4qnjvldpwg434g",
                    deleted: false,
                    description: "crazy little body",
                    email: "mike@strangerthings.com",
                    id: "cust_test_59utuigfksnvsed9mi4",
                    livemode: false,
                    location: "/customers/cust_test_59utuigfksnvsed9mi4",
                    metadata: %{},
                    object: "customer"
                  }}
      end
    end
  end

  describe "update/3" do
    test "updates customer" do
      use_cassette "update_customer" do
        assert Customer.update("cust_test_59uttqwkl62x5wf9qys", card: "tokn_test_59utvh4wxa7c2p4u8c6") ==
                 {:ok,
                  %Omise.Customer{
                    cards: %Omise.List{
                      data: [
                        %Omise.Card{
                          bank: "",
                          brand: "Visa",
                          city: "Bangkok",
                          country: "us",
                          created: "2017-11-04T11:28:33Z",
                          deleted: false,
                          expiration_month: 10,
                          expiration_year: 2019,
                          financing: "",
                          fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                          id: "card_test_59utvh4vu7cx3jrjtqx",
                          last_digits: "4242",
                          livemode: false,
                          location: "/customers/cust_test_59uttqwkl62x5wf9qys/cards/card_test_59utvh4vu7cx3jrjtqx",
                          name: "John Doe",
                          object: "card",
                          postal_code: "10320",
                          security_code_check: true
                        }
                      ],
                      from: "1970-01-01T00:00:00Z",
                      limit: 20,
                      location: "/customers/cust_test_59uttqwkl62x5wf9qys/cards",
                      object: "list",
                      offset: 0,
                      order: nil,
                      to: "2017-11-04T11:28:53Z",
                      total: 1
                    },
                    created: "2017-11-04T11:23:38Z",
                    default_card: "card_test_59utvh4vu7cx3jrjtqx",
                    deleted: false,
                    description: "crazy little girl",
                    email: "eleven@strangerthings.com",
                    id: "cust_test_59uttqwkl62x5wf9qys",
                    livemode: false,
                    location: "/customers/cust_test_59uttqwkl62x5wf9qys",
                    metadata: %{},
                    object: "customer"
                  }}
      end
    end
  end

  describe "destroy/2" do
    test "destroys customer" do
      use_cassette "destroy_customer" do
        assert Customer.destroy("cust_test_59uttqwkl62x5wf9qys") ==
                 {:ok,
                  %Omise.Customer{
                    cards: nil,
                    deleted: true,
                    id: "cust_test_59uttqwkl62x5wf9qys",
                    livemode: false,
                    object: "customer"
                  }}
      end
    end
  end

  describe "search/2" do
    test "searches all customers" do
      use_cassette "search_customers" do
        assert Customer.search(query: "mike") ==
                 {:ok,
                  %Omise.Search{
                    data: [
                      %Omise.Customer{
                        cards: %Omise.List{
                          data: [
                            %Omise.Card{
                              bank: "",
                              brand: "Visa",
                              city: "Bangkok",
                              country: "us",
                              created: "2017-11-04T11:24:43Z",
                              deleted: false,
                              expiration_month: 10,
                              expiration_year: 2019,
                              financing: "",
                              fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                              id: "card_test_59utu4qnjvldpwg434g",
                              last_digits: "4242",
                              livemode: false,
                              location: "/customers/cust_test_59utuigfksnvsed9mi4/cards/card_test_59utu4qnjvldpwg434g",
                              name: "John Doe",
                              object: "card",
                              postal_code: "10320",
                              security_code_check: true
                            }
                          ],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/customers/cust_test_59utuigfksnvsed9mi4/cards",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T11:35:31Z",
                          total: 1
                        },
                        created: "2017-11-04T11:25:48Z",
                        default_card: "card_test_59utu4qnjvldpwg434g",
                        deleted: false,
                        description: "crazy little body",
                        email: "mike@strangerthings.com",
                        id: "cust_test_59utuigfksnvsed9mi4",
                        livemode: false,
                        location: "/customers/cust_test_59utuigfksnvsed9mi4",
                        metadata: %{},
                        object: "customer"
                      }
                    ],
                    filters: %{},
                    location: "/search",
                    object: "search",
                    page: 1,
                    query: "mike",
                    scope: "customer",
                    total: 1,
                    total_pages: 1
                  }}
      end
    end
  end

  describe "list_cards/3" do
    test "lists all customer cards with given customer_id" do
      use_cassette "list_cards" do
        assert Customer.list_cards("cust_test_59utuigfksnvsed9mi4") ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Card{
                        bank: "",
                        brand: "Visa",
                        city: "Bangkok",
                        country: "us",
                        created: "2017-11-04T11:24:43Z",
                        deleted: false,
                        expiration_month: 10,
                        expiration_year: 2019,
                        financing: "",
                        fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                        id: "card_test_59utu4qnjvldpwg434g",
                        last_digits: "4242",
                        livemode: false,
                        location: "/customers/cust_test_59utuigfksnvsed9mi4/cards/card_test_59utu4qnjvldpwg434g",
                        name: "John Doe",
                        object: "card",
                        postal_code: "10320",
                        security_code_check: true
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 20,
                    location: nil,
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T11:37:46Z",
                    total: 1
                  }}
      end
    end
  end

  describe "retrieve_card/3" do
    test "retrieves customer card with customer_id and card_id" do
      use_cassette "retrieve_card" do
        assert Customer.retrieve_card("cust_test_59utuigfksnvsed9mi4", "card_test_59utu4qnjvldpwg434g") ==
                 {:ok,
                  %Omise.Card{
                    bank: "",
                    brand: "Visa",
                    city: "Bangkok",
                    country: "us",
                    created: "2017-11-04T11:24:43Z",
                    deleted: false,
                    expiration_month: 10,
                    expiration_year: 2019,
                    financing: "",
                    fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                    id: "card_test_59utu4qnjvldpwg434g",
                    last_digits: "4242",
                    livemode: false,
                    location: "/customers/cust_test_59utuigfksnvsed9mi4/cards/card_test_59utu4qnjvldpwg434g",
                    name: "John Doe",
                    object: "card",
                    postal_code: "10320",
                    security_code_check: true
                  }}
      end
    end
  end

  describe "update_card/4" do
    test "updates card" do
      use_cassette "update_card" do
        assert Customer.update_card(
                 "cust_test_59utuigfksnvsed9mi4",
                 "card_test_59utu4qnjvldpwg434g",
                 expiration_month: 11
               ) ==
                 {:ok,
                  %Omise.Card{
                    bank: "",
                    brand: "Visa",
                    city: "Bangkok",
                    country: "us",
                    created: "2017-11-04T11:24:43Z",
                    deleted: false,
                    expiration_month: 11,
                    expiration_year: 2019,
                    financing: "",
                    fingerprint: "WJhoQrhdxrPYDBcGBNeZu+R4TcX/D23HitUUud8tELs=",
                    id: "card_test_59utu4qnjvldpwg434g",
                    last_digits: "4242",
                    livemode: false,
                    location: "/customers/cust_test_59utuigfksnvsed9mi4/cards/card_test_59utu4qnjvldpwg434g",
                    name: "John Doe",
                    object: "card",
                    postal_code: "10320",
                    security_code_check: true
                  }}
      end
    end
  end

  describe "destroy_card/3" do
    test "destroys customer card" do
      use_cassette "destroy_card" do
        assert Customer.destroy_card("cust_test_59utuigfksnvsed9mi4", "card_test_59utu4qnjvldpwg434g") ==
                 {:ok,
                  %Omise.Card{
                    deleted: true,
                    id: "card_test_59utu4qnjvldpwg434g",
                    livemode: false,
                    object: "card"
                  }}
      end
    end
  end

  describe "list_schedules/3" do
    test "lists all charge schedules for given customer" do
      use_cassette "list_schedules" do
        assert Customer.list_schedules("cust_test_55c6cjwyr9kl4rt4jso", limit: 1) ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Schedule{
                        charge: %{
                          "amount" => 10000,
                          "card" => nil,
                          "currency" => "thb",
                          "customer" => "cust_test_55c6cjwyr9kl4rt4jso",
                          "description" => "Let the rain come down!"
                        },
                        created: "2017-05-30T07:25:10Z",
                        end_date: "2018-05-30",
                        every: 1,
                        id: "schd_test_584yqgiuavbzrfng7mv",
                        in_words: "Every 1 day(s)",
                        livemode: false,
                        location: "/schedules/schd_test_584yqgiuavbzrfng7mv",
                        next_occurrence_dates: [],
                        object: "schedule",
                        occurrences: %Omise.List{
                          data: [
                            %Omise.Occurrence{
                              created: "2017-05-30T07:25:10Z",
                              id: "occu_test_584yqgivyi2p1g828pl",
                              livemode: false,
                              location: "/occurrences/occu_test_584yqgivyi2p1g828pl",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-05-30T07:25:10Z",
                              result: "chrg_test_584yqgjb0pf8vj3lq1k",
                              retry_date: nil,
                              schedule: "schd_test_584yqgiuavbzrfng7mv",
                              schedule_date: "2017-05-30",
                              status: "successful"
                            }
                          ],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/schedules/schd_test_584yqgiuavbzrfng7mv/occurrences",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T11:48:48Z",
                          total: 1
                        },
                        on: %{},
                        period: "day",
                        start_date: "2017-05-30",
                        status: "deleted",
                        transfer: %{}
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 1,
                    location: "/customers/cust_test_55c6cjwyr9kl4rt4jso/schedules",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T11:48:48Z",
                    total: 18
                  }}
      end
    end
  end
end
