defmodule Omise.ScheduleTest do
  use Omise.TestCase

  it "can list all schedules", via: "schedules-get" do
    {:ok, list} = Omise.Schedule.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "schedule"))
  end

  it "can list all occurrences", via: "schedules/schd_test_584yqgiuavbzrfng7mv/occurrences-get" do
    {:ok, list} = Omise.Schedule.list_occurrences("schd_test_584yqgiuavbzrfng7mv")

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "occurrence"))
  end

  it "can retrieve the schedule", via: "schedules/schd_test_584yqgiuavbzrfng7mv-get" do
    {:ok, schedule} = Omise.Schedule.retrieve("schd_test_584yqgiuavbzrfng7mv")

    assert schedule.object == "schedule"
    assert schedule.id == "schd_test_584yqgiuavbzrfng7mv"
  end

  it "can create a schedule", via: "schedules-post" do
    {:ok, schedule} = Omise.Schedule.create(
      every:      2,
      period:     "day",
      start_date: "2017-12-01",
      end_date:   "2018-01-01",
      charge: [
        customer:    "cust_test_55c6cjwyr9kl4rt4jso",
        amount:      199_00,
        description: "Membership fee",
      ]
    )

    assert schedule.object == "schedule"
    assert schedule.status == "active"
    assert schedule.in_words == "Every 2 day(s)"
  end

  it "can destroy a schedule", via: "schedules/schd_test_584yqgiuavbzrfng7mv-delete" do
    {:ok, schedule} = Omise.Schedule.destroy("schd_test_584yqgiuavbzrfng7mv")

    assert schedule.object == "schedule"
    assert schedule.id == "schd_test_584yqgiuavbzrfng7mv"
    assert schedule.status == "deleted"
  end
end
