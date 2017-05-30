defmodule Omise.ChargeTest do
  use ExUnit.Case
  import TestHelper

  @charge_id "chrg_test_4yq7duw15p9hdrjp8oq"
  @refund_id "rfnd_test_4yqmv79ahghsiz23y3c"

  test "list all charges" do
    with_mock_request "charges-get", fn ->
      {:ok, list} =  Omise.Charge.list

      assert %Omise.List{data: charges} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each charges, fn(charge) ->
        assert %Omise.Charge{} = charge
        assert charge.object == "charge"
      end
    end
  end

  test "retrieve a charge" do
    with_mock_request "charges/#{@charge_id}-get", fn ->
      {:ok, charge} = Omise.Charge.retrieve(@charge_id)

      assert %Omise.Charge{} = charge
      assert charge.object == "charge"
      assert charge.id
      assert is_boolean(charge.livemode)
      assert charge.location
      assert charge.status
      assert charge.amount
      assert charge.currency
      assert charge.description
      assert is_boolean(charge.capture)
      assert is_boolean(charge.authorized)
      assert is_boolean(charge.reversed)
      assert is_boolean(charge.paid)
      assert charge.transaction
      assert charge.card
      assert charge.refunded
      assert charge.refunds
      refute charge.failure_code
      refute charge.failure_message
      assert charge.customer
      refute charge.ip
      assert charge.dispute
      assert charge.created
      refute charge.return_uri
      refute charge.authorize_uri
      refute charge.reference

      assert %Omise.Card{} = charge.card
      assert %Omise.List{} = charge.refunds
      assert %Omise.Dispute{} = charge.dispute
    end
  end

  test "create a charge" do
    with_mock_request "charges-post", fn ->
      {:ok, charge} = Omise.Charge.create(
        amount: 1000_00,
        currency: "thb",
        card: "tokn_test_12p4j8aeb6x1v7mk63x"
      )

      assert %Omise.Charge{} = charge
      assert charge.object == "charge"
      assert charge.location
      assert charge.authorized
      assert charge.capture
      assert charge.paid
      assert charge.amount == 1000_00
      assert charge.status == "successful"
    end
  end

  test "update a charge" do
    with_mock_request "charges/#{@charge_id}-patch", fn ->
      description = "Elixir is awesome"
      {:ok, charge} = Omise.Charge.update(@charge_id, description: description)

      assert %Omise.Charge{} = charge
      assert charge.object == "charge"
      assert charge.description == description
    end
  end

  test "capure a charge" do
    with_mock_request "charges/#{@charge_id}/capture-post", fn ->
      {:ok, charge} = Omise.Charge.capture(@charge_id)

      assert %Omise.Charge{} = charge
      assert charge.object == "charge"
      assert charge.paid
    end
  end

  test "reverse a charge" do
    with_mock_request "charges/#{@charge_id}/reverse-post", fn ->
      {:ok, charge} = Omise.Charge.reverse(@charge_id)

      assert %Omise.Charge{} = charge
      assert charge.object == "charge"
      assert charge.reversed
    end
  end

  test "search charges" do
    with_mock_request "search-charge-get", fn ->
      {:ok, search_data} =
        Omise.Charge.search(filters: [amount: 10_000, paid: true])

      assert %Omise.Search{data: data} = search_data
      assert search_data.object == "search"
      assert search_data.scope == "charge"
      assert search_data.query == ""
      assert search_data.filters == %{"amount" => "10000", "paid" => "true"}
      assert search_data.page == 1
      assert search_data.total_pages == 1
      assert search_data.total == 1
      assert is_list(data)
      Enum.each data, fn(charge) ->
        assert charge.amount == 1000000
        assert charge.paid
      end
    end
  end

  test "create a refund" do
    with_mock_request "charges/#{@charge_id}/refunds-post", fn ->
      {:ok, refund} = Omise.Charge.refund(@charge_id, amount: 100_00)

      assert %Omise.Refund{} = refund
      assert refund.object == "refund"
      assert refund.amount == 100_00
    end
  end

  test "list refunds" do
    with_mock_request "charges/#{@charge_id}/refunds-get", fn ->
      {:ok, list} = Omise.Charge.list_refunds(@charge_id)

      assert %Omise.List{data: refunds} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each refunds, fn(refund) ->
        assert %Omise.Refund{} = refund
        assert refund.object == "refund"
        assert refund.charge == @charge_id
      end
    end
  end

  test "retrieve a refund" do
    with_mock_request "charges/#{@charge_id}/refunds/#{@refund_id}-get", fn ->
      {:ok, refund} = Omise.Charge.retrieve_refund(@charge_id, @refund_id)

      assert %Omise.Refund{} = refund
      assert refund.object == "refund"
      assert refund.id
      assert refund.location
      assert refund.amount
      assert refund.currency
      assert is_boolean(refund.voided)
      assert refund.charge
      assert refund.transaction
      assert refund.created
    end
  end

  test "list all schedules" do
    with_mock_request "charges/schedules-get", fn ->
      {:ok, list} = Omise.Charge.list_schedules

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
end
