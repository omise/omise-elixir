defmodule Omise.ScheduleTest do
  use Omise.TestCase

  alias Omise.Schedule

  setup_all do: set_fixture_dir("schedule")

  describe "list/2" do
    test "lists all schedules" do
      use_cassette "list_schedules" do
        assert Schedule.list(from: "2017-10-01", limit: 1, order: "reverse_chronological") ==
                 {:ok, %Omise.List{
                   data: [
                     %Omise.Schedule{
                       charge: %{},
                       created: "2017-10-02T07:02:26Z",
                       end_date: "2018-05-01",
                       every: 1,
                       id: "schd_test_59hulv2s8cebp5davso",
                       in_words: "Every 1 week(s) on Monday and Friday",
                       livemode: false,
                       location: "/schedules/schd_test_59hulv2s8cebp5davso",
                       next_occurrence_dates: [
                         "2017-12-01",
                         "2017-12-04",
                         "2017-12-08",
                         "2017-12-11",
                         "2017-12-15",
                         "2017-12-18",
                         "2017-12-22",
                         "2017-12-25",
                         "2017-12-29",
                         "2018-01-01",
                         "2018-01-05",
                         "2018-01-08",
                         "2018-01-12",
                         "2018-01-15",
                         "2018-01-19",
                         "2018-01-22",
                         "2018-01-26",
                         "2018-01-29",
                         "2018-02-02",
                         "2018-02-05",
                         "2018-02-09",
                         "2018-02-12",
                         "2018-02-16",
                         "2018-02-19",
                         "2018-02-23",
                         "2018-02-26",
                         "2018-03-02",
                         "2018-03-05",
                         "2018-03-09",
                         "2018-03-12"
                       ],
                       object: "schedule",
                       occurrences: %Omise.List{
                         data: [],
                         from: "1970-01-01T00:00:00Z",
                         limit: 20,
                         location: "/schedules/schd_test_59hulv2s8cebp5davso/occurrences",
                         object: "list",
                         offset: 0,
                         order: nil,
                         to: "2017-11-04T13:29:42Z",
                         total: 0
                       },
                       on: %{"weekdays" => ["monday", "friday"]},
                       period: "week",
                       start_date: "2017-12-01",
                       status: "active",
                       transfer: %{
                         "amount" => nil,
                         "currency" => "thb",
                         "percentage_of_balance" => 75.0,
                         "recipient" => "recp_test_55j2lebbrscmwwdh9gm"
                       }
                     }
                   ],
                   from: "2017-10-01T00:00:00Z",
                   limit: 1,
                   location: "/schedules",
                   object: "list",
                   offset: 0,
                   order: "reverse_chronological",
                   to: "2017-11-04T13:29:42Z",
                   total: 9
                 }}
      end
    end
  end

  describe "list_occurrences/3" do
    test "list all occurrences of given schedule" do
      use_cassette "list_occurrences" do
        assert Schedule.list_occurrences("schd_test_59hsm5nodt6erfvkxda", limit: 2) ==
                 {:ok, %Omise.List{
                   data: [
                     %Omise.Occurrence{
                       created: "2017-10-02T03:38:44Z",
                       id: "occu_test_59hsm5nprb2cb2gtazw",
                       livemode: false,
                       location: "/occurrences/occu_test_59hsm5nprb2cb2gtazw",
                       message: nil,
                       object: "occurrence",
                       processed_at: "2017-10-10T01:30:07Z",
                       result: "chrg_test_59kw03oovul5pp97bgg",
                       retry_date: nil,
                       schedule: "schd_test_59hsm5nodt6erfvkxda",
                       schedule_date: "2017-10-10",
                       status: "successful"
                     },
                     %Omise.Occurrence{
                       created: "2017-10-10T01:30:07Z",
                       id: "occu_test_59kw04xh54j1sg4jm9n",
                       livemode: false,
                       location: "/occurrences/occu_test_59kw04xh54j1sg4jm9n",
                       message: nil,
                       object: "occurrence",
                       processed_at: "2017-10-12T01:30:03Z",
                       result: "chrg_test_59lo5wwqohps3zecwwt",
                       retry_date: nil,
                       schedule: "schd_test_59hsm5nodt6erfvkxda",
                       schedule_date: "2017-10-12",
                       status: "successful"
                     }
                   ],
                   from: "1970-01-01T00:00:00Z",
                   limit: 2,
                   location: nil,
                   object: "list",
                   offset: 0,
                   order: "chronological",
                   to: "2017-11-04T13:33:08Z",
                   total: 13
                 }}
      end
    end
  end

  describe "retrieve/2" do
    test "retrieves schedule" do
      use_cassette "retrieve_schedule" do
        assert Schedule.retrieve("schd_test_59hulv2s8cebp5davso") ==
                 {:ok, %Omise.Schedule{
                   charge: %{},
                   created: "2017-10-02T07:02:26Z",
                   end_date: "2018-05-01",
                   every: 1,
                   id: "schd_test_59hulv2s8cebp5davso",
                   in_words: "Every 1 week(s) on Monday and Friday",
                   livemode: false,
                   location: "/schedules/schd_test_59hulv2s8cebp5davso",
                   next_occurrence_dates: [
                     "2017-12-01",
                     "2017-12-04",
                     "2017-12-08",
                     "2017-12-11",
                     "2017-12-15",
                     "2017-12-18",
                     "2017-12-22",
                     "2017-12-25",
                     "2017-12-29",
                     "2018-01-01",
                     "2018-01-05",
                     "2018-01-08",
                     "2018-01-12",
                     "2018-01-15",
                     "2018-01-19",
                     "2018-01-22",
                     "2018-01-26",
                     "2018-01-29",
                     "2018-02-02",
                     "2018-02-05",
                     "2018-02-09",
                     "2018-02-12",
                     "2018-02-16",
                     "2018-02-19",
                     "2018-02-23",
                     "2018-02-26",
                     "2018-03-02",
                     "2018-03-05",
                     "2018-03-09",
                     "2018-03-12"
                   ],
                   object: "schedule",
                   occurrences: %Omise.List{
                     data: [],
                     from: "1970-01-01T00:00:00Z",
                     limit: 20,
                     location: "/schedules/schd_test_59hulv2s8cebp5davso/occurrences",
                     object: "list",
                     offset: 0,
                     order: nil,
                     to: "2017-11-04T13:37:49Z",
                     total: 0
                   },
                   on: %{"weekdays" => ["monday", "friday"]},
                   period: "week",
                   start_date: "2017-12-01",
                   status: "active",
                   transfer: %{
                     "amount" => nil,
                     "currency" => "thb",
                     "percentage_of_balance" => 75.0,
                     "recipient" => "recp_test_55j2lebbrscmwwdh9gm"
                   }
                 }}
      end
    end
  end

  describe "create/2" do
    test "creates charge schedule" do
      use_cassette "create_charge_schedule" do
        assert Schedule.create(
                 every: 1,
                 period: "month",
                 on: [
                   days_of_month: [15]
                 ],
                 start_date: "2017-12-15",
                 end_date: "2018-03-15",
                 charge: [
                   customer: "cust_test_59ur2ob5ltcsl9vjwb4",
                   amount: 199_00,
                   description: "Membership fee"
                 ]
               ) ==
                 {:ok, %Omise.Schedule{
                   charge: %{
                     "amount" => 19900,
                     "card" => nil,
                     "currency" => "thb",
                     "customer" => "cust_test_59ur2ob5ltcsl9vjwb4",
                     "description" => "Membership fee"
                   },
                   created: "2017-11-04T13:47:24Z",
                   end_date: "2018-03-15",
                   every: 1,
                   id: "schd_test_59uv8cx9595f4zttqax",
                   in_words: "Every 1 month(s) on the 15th",
                   livemode: false,
                   location: "/schedules/schd_test_59uv8cx9595f4zttqax",
                   next_occurrence_dates: ["2017-12-15", "2018-01-15", "2018-02-15", "2018-03-15"],
                   object: "schedule",
                   occurrences: %Omise.List{
                     data: [],
                     from: "1970-01-01T00:00:00Z",
                     limit: 20,
                     location: "/schedules/schd_test_59uv8cx9595f4zttqax/occurrences",
                     object: "list",
                     offset: 0,
                     order: nil,
                     to: "2017-11-04T13:47:24Z",
                     total: 0
                   },
                   on: %{"days_of_month" => [15]},
                   period: "month",
                   start_date: "2017-12-15",
                   status: "active",
                   transfer: %{}
                 }}
      end
    end

    test "creates transfer schedule" do
      use_cassette "create_transfer_schedule" do
        assert Schedule.create(
                 every: 10,
                 period: "day",
                 start_date: "2017-11-10",
                 end_date: "2017-12-31",
                 transfer: [
                   recipient: "recp_test_55j2lryr9wfpxm5c7js",
                   amount: 10_000_00
                 ]
               ) ==
                 {:ok, %Omise.Schedule{
                   charge: %{},
                   created: "2017-11-04T13:43:19Z",
                   end_date: "2017-12-31",
                   every: 10,
                   id: "schd_test_59uv6x4k6oj4swchy3c",
                   in_words: "Every 10 day(s)",
                   livemode: false,
                   location: "/schedules/schd_test_59uv6x4k6oj4swchy3c",
                   next_occurrence_dates: [
                     "2017-11-10",
                     "2017-11-20",
                     "2017-11-30",
                     "2017-12-10",
                     "2017-12-20",
                     "2017-12-30"
                   ],
                   object: "schedule",
                   occurrences: %Omise.List{
                     data: [],
                     from: "1970-01-01T00:00:00Z",
                     limit: 20,
                     location: "/schedules/schd_test_59uv6x4k6oj4swchy3c/occurrences",
                     object: "list",
                     offset: 0,
                     order: nil,
                     to: "2017-11-04T13:43:19Z",
                     total: 0
                   },
                   on: %{},
                   period: "day",
                   start_date: "2017-11-10",
                   status: "active",
                   transfer: %{
                     "amount" => 1_000_000,
                     "currency" => "thb",
                     "percentage_of_balance" => nil,
                     "recipient" => "recp_test_55j2lryr9wfpxm5c7js"
                   }
                 }}
      end
    end
  end

  describe "destroy/2" do
    test "destroys schedule" do
      use_cassette "destroy_schedule" do
        assert Schedule.destroy("schd_test_59uv6x4k6oj4swchy3c") ==
                 {:ok, %Omise.Schedule{
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
                     to: "2017-11-04T13:49:19Z",
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
                 }}
      end
    end
  end
end
