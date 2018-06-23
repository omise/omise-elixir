defmodule Omise.RecipientTest do
  use Omise.TestCase, async: true

  alias Omise.Recipient

  setup do: set_fixture_dir("recipient")

  describe "list/2" do
    test "lists all recipients" do
      use_cassette "list_recipients" do
        assert Recipient.list(limit: 2) ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Recipient{
                        active: true,
                        bank_account: %Omise.BankAccount{
                          account_type: nil,
                          bank_code: nil,
                          branch_code: nil,
                          brand: "test",
                          created: "2016-08-31T05:22:15Z",
                          deleted: false,
                          last_digits: "6789",
                          name: "DEFAULT BANK ACCOUNT",
                          object: "bank_account"
                        },
                        created: "2016-08-31T05:22:15Z",
                        deleted: false,
                        description: "Default recipient",
                        email: "m.mantastyle@gmail.com",
                        failure_code: nil,
                        id: "recp_test_556jkf7u174ptxuytac",
                        livemode: false,
                        location: "/recipients/recp_test_556jkf7u174ptxuytac",
                        name: "The A-Team",
                        object: "recipient",
                        tax_id: "",
                        type: "individual",
                        verified: true
                      },
                      %Omise.Recipient{
                        active: true,
                        bank_account: %Omise.BankAccount{
                          account_type: nil,
                          bank_code: nil,
                          branch_code: nil,
                          brand: "tmb",
                          created: "2016-10-02T05:37:00Z",
                          deleted: false,
                          last_digits: "7890",
                          name: "Omega",
                          object: "bank_account"
                        },
                        created: "2016-10-02T05:37:00Z",
                        deleted: false,
                        description: "",
                        email: "omega@gmail.com",
                        failure_code: nil,
                        id: "recp_test_55j2an6c8fd07xbccd3",
                        livemode: false,
                        location: "/recipients/recp_test_55j2an6c8fd07xbccd3",
                        name: "Omega",
                        object: "recipient",
                        tax_id: "1212312121",
                        type: "individual",
                        verified: true
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 2,
                    location: "/recipients",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T12:54:16Z",
                    total: 12
                  }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves recipient" do
      use_cassette "retrieve_recipient" do
        assert Recipient.retrieve("recp_test_55j2lryr9wfpxm5c7js") ==
                 {:ok,
                  %Omise.Recipient{
                    active: true,
                    bank_account: %Omise.BankAccount{
                      account_type: nil,
                      bank_code: nil,
                      branch_code: nil,
                      brand: "bnp",
                      created: "2016-10-02T06:08:37Z",
                      deleted: false,
                      last_digits: "7890",
                      name: "Mary Elizabeth Winstead",
                      object: "bank_account"
                    },
                    created: "2016-10-02T06:08:37Z",
                    deleted: false,
                    description: "",
                    email: "mary@omise.co",
                    failure_code: nil,
                    id: "recp_test_55j2lryr9wfpxm5c7js",
                    livemode: false,
                    location: "/recipients/recp_test_55j2lryr9wfpxm5c7js",
                    name: "Mary Elizabeth Winstead",
                    object: "recipient",
                    tax_id: "",
                    type: "individual",
                    verified: true
                  }}
      end
    end
  end

  describe "create/2" do
    test "creates recipient" do
      use_cassette "create_recipient" do
        assert Recipient.create(
                 name: "Dua Lipa",
                 email: "dua@gmail.com",
                 description: "One! Don't pick up the phone...",
                 type: "individual",
                 bank_account: [
                   brand: "bbl",
                   number: "1234567890",
                   name: "Dua Lipa"
                 ]
               ) ==
                 {:ok,
                  %Omise.Recipient{
                    active: false,
                    bank_account: %Omise.BankAccount{
                      account_type: nil,
                      bank_code: nil,
                      branch_code: nil,
                      brand: "bbl",
                      created: "2017-11-04T12:58:05Z",
                      deleted: false,
                      last_digits: "7890",
                      name: "Dua Lipa",
                      object: "bank_account"
                    },
                    created: "2017-11-04T12:58:05Z",
                    deleted: false,
                    description: "One! Don't pick up the phone...",
                    email: "dua@gmail.com",
                    failure_code: nil,
                    id: "recp_test_59uuqzsagk159pa08gc",
                    livemode: false,
                    location: "/recipients/recp_test_59uuqzsagk159pa08gc",
                    name: "Dua Lipa",
                    object: "recipient",
                    tax_id: nil,
                    type: "individual",
                    verified: false
                  }}
      end
    end
  end

  describe "update/3" do
    test "updates recipient" do
      use_cassette "update_recipient" do
        assert Recipient.update("recp_test_59uuqzsagk159pa08gc", description: "I got new rules, I count them.") ==
                 {:ok,
                  %Omise.Recipient{
                    active: false,
                    bank_account: %Omise.BankAccount{
                      account_type: nil,
                      bank_code: nil,
                      branch_code: nil,
                      brand: "bbl",
                      created: "2017-11-04T12:58:05Z",
                      deleted: false,
                      last_digits: "7890",
                      name: "Dua Lipa",
                      object: "bank_account"
                    },
                    created: "2017-11-04T12:58:05Z",
                    deleted: false,
                    description: "I got new rules, I count them.",
                    email: "dua@gmail.com",
                    failure_code: nil,
                    id: "recp_test_59uuqzsagk159pa08gc",
                    livemode: false,
                    location: "/recipients/recp_test_59uuqzsagk159pa08gc",
                    name: "Dua Lipa",
                    object: "recipient",
                    tax_id: nil,
                    type: "individual",
                    verified: false
                  }}
      end
    end
  end

  describe "destroy/2" do
    test "destroys recipient" do
      use_cassette "destroy_recipient" do
        assert Recipient.destroy("recp_test_59uuqzsagk159pa08gc") ==
                 {:ok,
                  %Omise.Recipient{
                    bank_account: %Omise.BankAccount{},
                    deleted: true,
                    id: "recp_test_59uuqzsagk159pa08gc",
                    livemode: false,
                    object: "recipient"
                  }}
      end
    end
  end

  describe "search/2" do
    test "searches all recipients" do
      use_cassette "search_recipients" do
        assert Recipient.search(filters: [type: "corporation"]) ==
                 {:ok,
                  %Omise.Search{
                    data: [],
                    filters: %{"type" => "corporation"},
                    location: "/search",
                    object: "search",
                    page: 1,
                    query: "",
                    scope: "recipient",
                    total: 0,
                    total_pages: 0
                  }}
      end
    end
  end

  describe "list_schedules/3" do
    test "list all transfer schedules" do
      use_cassette "list_schedules" do
        assert Recipient.list_schedules("recp_test_556jkf7u174ptxuytac", limit: 3) ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Schedule{
                        charge: %{},
                        created: "2017-07-07T12:05:58Z",
                        end_date: "2017-07-31",
                        every: 1,
                        id: "schd_test_58jwjs4bfpbjaijsfua",
                        in_words: "Every 1 week(s) on Monday and Friday",
                        livemode: false,
                        location: "/schedules/schd_test_58jwjs4bfpbjaijsfua",
                        next_occurrence_dates: [],
                        object: "schedule",
                        occurrences: %Omise.List{
                          data: [
                            %Omise.Occurrence{
                              created: "2017-07-07T12:05:58Z",
                              id: "occu_test_58jwjs4dm573k86svls",
                              livemode: false,
                              location: "/occurrences/occu_test_58jwjs4dm573k86svls",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-07-10T01:05:00Z",
                              result: "trsf_test_58kwbtuoidqosq0gike",
                              retry_date: nil,
                              schedule: "schd_test_58jwjs4bfpbjaijsfua",
                              schedule_date: "2017-07-10",
                              status: "successful"
                            },
                            %Omise.Occurrence{
                              created: "2017-07-10T01:05:00Z",
                              id: "occu_test_58kwbtvuf5jegs518bt",
                              livemode: false,
                              location: "/occurrences/occu_test_58kwbtvuf5jegs518bt",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-07-14T01:05:00Z",
                              result: "trsf_test_58mgngj62m4vnccbsqt",
                              retry_date: nil,
                              schedule: "schd_test_58jwjs4bfpbjaijsfua",
                              schedule_date: "2017-07-14",
                              status: "successful"
                            },
                            %Omise.Occurrence{
                              created: "2017-07-14T01:05:00Z",
                              id: "occu_test_58mgngkjlxxfpimtt2h",
                              livemode: false,
                              location: "/occurrences/occu_test_58mgngkjlxxfpimtt2h",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-07-17T01:05:00Z",
                              result: "trsf_test_58nmw6hoe0zk3jcpa2p",
                              retry_date: nil,
                              schedule: "schd_test_58jwjs4bfpbjaijsfua",
                              schedule_date: "2017-07-17",
                              status: "successful"
                            },
                            %Omise.Occurrence{
                              created: "2017-07-17T01:05:00Z",
                              id: "occu_test_58nmw6izzzhsiyo3dg5",
                              livemode: false,
                              location: "/occurrences/occu_test_58nmw6izzzhsiyo3dg5",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-07-21T01:05:00Z",
                              result: "trsf_test_58p77t4ancfp9ziged9",
                              retry_date: nil,
                              schedule: "schd_test_58jwjs4bfpbjaijsfua",
                              schedule_date: "2017-07-21",
                              status: "successful"
                            },
                            %Omise.Occurrence{
                              created: "2017-07-21T01:05:00Z",
                              id: "occu_test_58p77t5x791bn8eannk",
                              livemode: false,
                              location: "/occurrences/occu_test_58p77t5x791bn8eannk",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-07-24T01:05:00Z",
                              result: "trsf_test_58qdgj3wlj22uichp0w",
                              retry_date: nil,
                              schedule: "schd_test_58jwjs4bfpbjaijsfua",
                              schedule_date: "2017-07-24",
                              status: "successful"
                            },
                            %Omise.Occurrence{
                              created: "2017-07-24T01:05:00Z",
                              id: "occu_test_58qdgj527nxcdy90pg4",
                              livemode: false,
                              location: "/occurrences/occu_test_58qdgj527nxcdy90pg4",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-07-28T01:05:00Z",
                              result: "trsf_test_58rxs5qll5nbxv4hz9q",
                              retry_date: nil,
                              schedule: "schd_test_58jwjs4bfpbjaijsfua",
                              schedule_date: "2017-07-28",
                              status: "successful"
                            },
                            %Omise.Occurrence{
                              created: "2017-07-28T01:05:00Z",
                              id: "occu_test_58rxs5rqdwgnt4hv8w7",
                              livemode: false,
                              location: "/occurrences/occu_test_58rxs5rqdwgnt4hv8w7",
                              message: nil,
                              object: "occurrence",
                              processed_at: "2017-07-31T01:05:00Z",
                              result: "trsf_test_58t40vpz4rb88c9rad2",
                              retry_date: nil,
                              schedule: "schd_test_58jwjs4bfpbjaijsfua",
                              schedule_date: "2017-07-31",
                              status: "successful"
                            }
                          ],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/schedules/schd_test_58jwjs4bfpbjaijsfua/occurrences",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T13:12:42Z",
                          total: 7
                        },
                        on: %{"weekdays" => ["monday", "friday"]},
                        period: "week",
                        start_date: "2017-07-08",
                        status: "expired",
                        transfer: %{
                          "amount" => nil,
                          "currency" => "thb",
                          "percentage_of_balance" => 75.0,
                          "recipient" => "recp_test_556jkf7u174ptxuytac"
                        }
                      },
                      %Omise.Schedule{
                        charge: %{},
                        created: "2017-10-02T06:55:00Z",
                        end_date: "2018-05-01",
                        every: 2,
                        id: "schd_test_59huj8r7jt2i5zljfxs",
                        in_words: "Every 2 day(s)",
                        livemode: false,
                        location: "/schedules/schd_test_59huj8r7jt2i5zljfxs",
                        next_occurrence_dates: [
                          "2017-12-01",
                          "2017-12-03",
                          "2017-12-05",
                          "2017-12-07",
                          "2017-12-09",
                          "2017-12-11",
                          "2017-12-13",
                          "2017-12-15",
                          "2017-12-17",
                          "2017-12-19",
                          "2017-12-21",
                          "2017-12-23",
                          "2017-12-25",
                          "2017-12-27",
                          "2017-12-29",
                          "2017-12-31",
                          "2018-01-02",
                          "2018-01-04",
                          "2018-01-06",
                          "2018-01-08",
                          "2018-01-10",
                          "2018-01-12",
                          "2018-01-14",
                          "2018-01-16",
                          "2018-01-18",
                          "2018-01-20",
                          "2018-01-22",
                          "2018-01-24",
                          "2018-01-26",
                          "2018-01-28"
                        ],
                        object: "schedule",
                        occurrences: %Omise.List{
                          data: [],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/schedules/schd_test_59huj8r7jt2i5zljfxs/occurrences",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T13:12:43Z",
                          total: 0
                        },
                        on: %{},
                        period: "day",
                        start_date: "2017-12-01",
                        status: "active",
                        transfer: %{
                          "amount" => 1_000_000,
                          "currency" => "thb",
                          "percentage_of_balance" => nil,
                          "recipient" => "recp_test_556jkf7u174ptxuytac"
                        }
                      }
                    ],
                    from: "1970-01-01T00:00:00Z",
                    limit: 3,
                    location: "/recipients/recp_test_556jkf7u174ptxuytac/schedules",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T13:12:42Z",
                    total: 2
                  }}
      end
    end
  end
end
