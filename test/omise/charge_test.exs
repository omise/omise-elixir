defmodule Omise.ChargeTest do
  use Omise.TestCase

  it "can list all charges", via: "charges-get" do
    {:ok, list} = Omise.Charge.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "charge"))
  end

  it "can retrieve the charge", via: "charges/chrg_test_4yq7duw15p9hdrjp8oq-get" do
    {:ok, charge} = Omise.Charge.retrieve("chrg_test_4yq7duw15p9hdrjp8oq")

    assert charge.object == "charge"
    assert charge.id == "chrg_test_4yq7duw15p9hdrjp8oq"
  end

  it "can create a charge", via: "charges-post" do
    {:ok, charge} = Omise.Charge.create(
      amount:   100000,
      currency: "thb",
      card:     "tokn_test_12p4j8aeb6x1v7mk63x"
    )

    assert charge.object == "charge"
    assert charge.amount == 100000
  end

  it "can update the charge", via: "charges/chrg_test_4yq7duw15p9hdrjp8oq-patch" do
    {:ok, charge} = Omise.Charge.update("chrg_test_4yq7duw15p9hdrjp8oq", description: "Elixir is awesome")

    assert charge.object == "charge"
    assert charge.description == "Elixir is awesome"
  end

  it "can capture the charge", via: "charges/chrg_test_4yq7duw15p9hdrjp8oq/capture-post" do
    {:ok, charge} = Omise.Charge.capture("chrg_test_4yq7duw15p9hdrjp8oq")

    assert charge.object == "charge"
    assert charge.paid
  end

  it "can reverse the charge", via: "charges/chrg_test_4yq7duw15p9hdrjp8oq/reverse-post" do
    {:ok, charge} = Omise.Charge.reverse("chrg_test_4yq7duw15p9hdrjp8oq")

    assert charge.object == "charge"
    assert charge.reversed
  end

  it "can search for charges", via: "search-charge-get" do
    {:ok, search} = Omise.Charge.search(filters: [amount: 10_000, paid: true])

    assert search.object == "search"
    assert search.scope == "charge"
    assert search.query == ""
    assert search.filters == %{"amount" => "10000", "paid" => "true"}
    assert is_list(search.data)
  end

  it "can create a refund", via: "charges/chrg_test_4yq7duw15p9hdrjp8oq/refunds-post" do
    {:ok, refund} = Omise.Charge.refund("chrg_test_4yq7duw15p9hdrjp8oq", amount: 10000)

    assert refund.object == "refund"
    assert refund.amount == 10000
  end

  it "can lists all refunds", via: "charges/chrg_test_4yq7duw15p9hdrjp8oq/refunds-get" do
    {:ok, list} = Omise.Charge.list_refunds("chrg_test_4yq7duw15p9hdrjp8oq")

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "refund"))
  end

  it "can retrieve the refund", via: "charges/chrg_test_4yq7duw15p9hdrjp8oq/refunds/rfnd_test_4yqmv79ahghsiz23y3c-get" do
    {:ok, refund} = Omise.Charge.retrieve_refund("chrg_test_4yq7duw15p9hdrjp8oq", "rfnd_test_4yqmv79ahghsiz23y3c")

    assert refund.object == "refund"
    assert refund.id == "rfnd_test_4yqmv79ahghsiz23y3c"
  end

  it "can list all schedules", via: "charges/schedules-get" do
    {:ok, list} = Omise.Charge.list_schedules

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "schedule"))
  end
end
