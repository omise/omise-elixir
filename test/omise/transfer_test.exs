defmodule Omise.TransferTest do
  use Omise.TestCase, async: true

  alias Omise.Transfer

  setup do: set_fixture_dir("transfer")

  describe "list/2" do
    test "lists all transfers" do
      use_cassette "list_transfers" do
        assert Transfer.list(from: "2017-10-01") ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Transfer{
                        amount: 50000,
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
                        created: "2017-10-02T07:32:50Z",
                        currency: "thb",
                        deleted: false,
                        failure_code: nil,
                        failure_message: nil,
                        fee: 3000,
                        id: "trsf_test_59huwk9pwlqyno5w8aj",
                        livemode: false,
                        location: "/transfers/trsf_test_59huwk9pwlqyno5w8aj",
                        object: "transfer",
                        paid: false,
                        recipient: "recp_test_556jkf7u174ptxuytac",
                        sent: false,
                        transaction: nil
                      },
                      %Omise.Transfer{
                        amount: 100_000,
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
                        created: "2017-10-02T15:06:18Z",
                        currency: "thb",
                        deleted: false,
                        failure_code: nil,
                        failure_message: nil,
                        fee: 3000,
                        id: "trsf_test_59hzc6ttkz93cztqbgk",
                        livemode: false,
                        location: "/transfers/trsf_test_59hzc6ttkz93cztqbgk",
                        object: "transfer",
                        paid: true,
                        recipient: "recp_test_556jkf7u174ptxuytac",
                        sent: true,
                        transaction: "trxn_test_59i9afontdj37o5xlta"
                      }
                    ],
                    from: "2017-10-01T00:00:00Z",
                    limit: 20,
                    location: "/transfers",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T14:24:10Z",
                    total: 2
                  }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves transfer" do
      use_cassette "retrieve_transfer" do
        assert Transfer.retrieve("trsf_test_59hzc6ttkz93cztqbgk") ==
                 {:ok,
                  %Omise.Transfer{
                    amount: 100_000,
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
                    created: "2017-10-02T15:06:18Z",
                    currency: "thb",
                    deleted: false,
                    failure_code: nil,
                    failure_message: nil,
                    fee: 3000,
                    id: "trsf_test_59hzc6ttkz93cztqbgk",
                    livemode: false,
                    location: "/transfers/trsf_test_59hzc6ttkz93cztqbgk",
                    object: "transfer",
                    paid: true,
                    recipient: "recp_test_556jkf7u174ptxuytac",
                    sent: true,
                    transaction: "trxn_test_59i9afontdj37o5xlta"
                  }}
      end
    end
  end

  describe "create/2" do
    test "creates transfer to default recipient" do
      use_cassette "create_transfer_to_default_recipient" do
        assert Transfer.create(amount: 5000_00) ==
                 {:ok,
                  %Omise.Transfer{
                    amount: 500_000,
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
                    created: "2017-11-04T14:28:22Z",
                    currency: "thb",
                    deleted: false,
                    failure_code: nil,
                    failure_message: nil,
                    fee: 3000,
                    id: "trsf_test_59uvmrw7uo0c2om9ros",
                    livemode: false,
                    location: "/transfers/trsf_test_59uvmrw7uo0c2om9ros",
                    object: "transfer",
                    paid: false,
                    recipient: "recp_test_556jkf7u174ptxuytac",
                    sent: false,
                    transaction: nil
                  }}
      end
    end

    test "creates transfer to third-party recipient" do
      use_cassette "create_transfer_to_third_party_recipient" do
        assert Transfer.create(
                 amount: 5000_00,
                 recipient: "recp_test_55j2lebbrscmwwdh9gm"
               ) ==
                 {:ok,
                  %Omise.Transfer{
                    amount: 500_000,
                    bank_account: %Omise.BankAccount{
                      account_type: nil,
                      bank_code: nil,
                      branch_code: nil,
                      brand: "lhb",
                      created: "2016-10-02T06:07:33Z",
                      deleted: false,
                      last_digits: "7890",
                      name: "Margot Robbie",
                      object: "bank_account"
                    },
                    created: "2017-11-04T14:28:21Z",
                    currency: "thb",
                    deleted: false,
                    failure_code: nil,
                    failure_message: nil,
                    fee: 3000,
                    id: "trsf_test_59uvmrtx6v57s2xrvh4",
                    livemode: false,
                    location: "/transfers/trsf_test_59uvmrtx6v57s2xrvh4",
                    object: "transfer",
                    paid: false,
                    recipient: "recp_test_55j2lebbrscmwwdh9gm",
                    sent: false,
                    transaction: nil
                  }}
      end
    end
  end

  describe "update/3" do
    test "updates transfer" do
      use_cassette "update_transfer" do
        assert Transfer.update("trsf_test_59uvmrtx6v57s2xrvh4", amount: 3500_00) ==
                 {:ok,
                  %Omise.Transfer{
                    amount: 350_000,
                    bank_account: %Omise.BankAccount{
                      account_type: nil,
                      bank_code: nil,
                      branch_code: nil,
                      brand: "lhb",
                      created: "2016-10-02T06:07:33Z",
                      deleted: false,
                      last_digits: "7890",
                      name: "Margot Robbie",
                      object: "bank_account"
                    },
                    created: "2017-11-04T14:28:21Z",
                    currency: "thb",
                    deleted: false,
                    failure_code: nil,
                    failure_message: nil,
                    fee: 3000,
                    id: "trsf_test_59uvmrtx6v57s2xrvh4",
                    livemode: false,
                    location: "/transfers/trsf_test_59uvmrtx6v57s2xrvh4",
                    object: "transfer",
                    paid: false,
                    recipient: "recp_test_55j2lebbrscmwwdh9gm",
                    sent: false,
                    transaction: nil
                  }}
      end
    end
  end

  describe "destroy/2" do
    test "destroys transfer" do
      use_cassette "destroy_transfer" do
        assert Transfer.destroy("trsf_test_59uvmrtx6v57s2xrvh4") ==
                 {:ok,
                  %Omise.Transfer{
                    bank_account: nil,
                    deleted: true,
                    id: "trsf_test_59uvmrtx6v57s2xrvh4",
                    livemode: false,
                    object: "transfer"
                  }}
      end
    end
  end

  describe "list_schedules/2" do
    test "lists all transfer schedules" do
      use_cassette "list_schedules" do
        assert Transfer.list_schedules(from: "2017-11-01") ==
                 {:ok,
                  %Omise.List{
                    data: [
                      %Omise.Schedule{
                        charge: %{},
                        created: "2017-11-04T13:43:19Z",
                        end_date: "2017-12-31",
                        every: 10,
                        id: "schd_test_59uv6x4k6oj4swchy3c",
                        in_words: "Every 10 day(s)",
                        livemode: false,
                        location: "/schedules/schd_test_59uv6x4k6oj4swchy3c",
                        next_occurrence_dates: [],
                        object: "schedule",
                        occurrences: %Omise.List{
                          data: [],
                          from: "1970-01-01T00:00:00Z",
                          limit: 20,
                          location: "/schedules/schd_test_59uv6x4k6oj4swchy3c/occurrences",
                          object: "list",
                          offset: 0,
                          order: nil,
                          to: "2017-11-04T14:34:56Z",
                          total: 0
                        },
                        on: %{},
                        period: "day",
                        start_date: "2017-11-10",
                        status: "deleted",
                        transfer: %{
                          "amount" => 1_000_000,
                          "currency" => "thb",
                          "percentage_of_balance" => nil,
                          "recipient" => "recp_test_55j2lryr9wfpxm5c7js"
                        }
                      }
                    ],
                    from: "2017-11-01T00:00:00Z",
                    limit: 20,
                    location: "/transfers/schedules",
                    object: "list",
                    offset: 0,
                    order: "chronological",
                    to: "2017-11-04T14:34:56Z",
                    total: 1
                  }}
      end
    end
  end
end
