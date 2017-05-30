defmodule Omise.ScheduleTest do
  use ExUnit.Case
  import TestHelper

  @schedule_id "schd_test_584yqgiuavbzrfng7mv"

  test "list all schedules" do
    with_mock_request "schedules-get", fn ->
      {:ok, list} =  Omise.Schedule.list

      assert %Omise.List{data: schedules} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each schedules, fn(schedule) ->
        assert %Omise.Schedule{} = schedule
        assert schedule.object == "schedule"
      end
    end
  end

  test "list all occurrences" do
    with_mock_request "schedules/#{@schedule_id}/occurrences-get", fn ->
      {:ok, list} =  Omise.Schedule.list_occurrences(@schedule_id)

      assert %Omise.List{data: occurrences} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each occurrences, fn(occurrence) ->
        assert %Omise.Occurrence{} = occurrence
        assert occurrence.object == "occurrence"
      end
    end
  end

  test "retrieve a schedule" do
    with_mock_request "schedules/#{@schedule_id}-get", fn ->
      {:ok, schedule} = Omise.Schedule.retrieve(@schedule_id)

      assert %Omise.Schedule{} = schedule
      assert schedule.object == "schedule"
      assert schedule.id
      assert is_boolean(schedule.livemode)
      assert schedule.location
      assert schedule.status
      assert is_boolean(schedule.deleted)
      assert schedule.every
      assert schedule.period
      assert is_map(schedule.on)
      assert schedule.in_words
      assert schedule.start_date
      assert schedule.end_date
      assert is_map(schedule.charge)
      assert %Omise.List{} = schedule.occurrences
      assert is_list(schedule.next_occurrence_dates)
      assert schedule.created
    end
  end

  test "create a schedule" do
    with_mock_request "schedules-post", fn ->
      {:ok, schedule} = Omise.Schedule.create(
        every: 2,
        period: "day",
        start_date: "2017-06-5",
        end_date: "2018-05-01",
        charge: [
          customer: "cust_test_55c6cjwyr9kl4rt4jso",
          amount: 199_00,
          description: "Membership fee",
        ]
      )

      assert %Omise.Schedule{} = schedule
      assert schedule.object == "schedule"
      assert schedule.location
      assert schedule.status == "active"
      assert schedule.every == 2
      assert schedule.period == "day"
      assert schedule.in_words == "Every 2 day(s)"
      assert schedule.charge["amount"] == 19900
      assert schedule.charge["currency"] == "thb"
      assert schedule.charge["description"] == "Membership fee"
      assert schedule.charge["customer"] == "cust_test_55c6cjwyr9kl4rt4jso"
      assert schedule.charge["card"] == nil
    end
  end

  test "destroy a schedule"  do
    with_mock_request "schedules/#{@schedule_id}-delete", fn ->
      {:ok, schedule} = Omise.Schedule.destroy(@schedule_id)

      assert %Omise.Schedule{} = schedule
      assert schedule.id == @schedule_id
      assert schedule.deleted
      assert schedule.status == "deleted"
      assert schedule.next_occurrence_dates == []
    end
  end
end
