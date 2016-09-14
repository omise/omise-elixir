defmodule Omise.UtilsTest do
  use ExUnit.Case

  alias Omise.Utils

  test "normalize card params" do
    params = [
      name: "Lana Del Rey",
      number: 4242424242424242,
      security_code: 999,
      expiration_month: 10,
      expiration_year: 2022
    ]

    assert Utils.normalize_card_params(params) ==
      [
        {"card[name]", "Lana Del Rey"},
        {"card[number]", 4242424242424242},
        {"card[security_code]", 999},
        {"card[expiration_month]", 10},
        {"card[expiration_year]", 2022},

      ]
  end

  test "normalize recipient params" do
    params = [
      name: "Emma Stone",
      email: "emma@omise.co",
      bank_account: [
        brand: "bbl",
        number: "1234567890",
        name: "Emma Stone"
      ]
    ]

    assert Utils.normalize_recipient_params(params) ==
      [
        {:name, "Emma Stone"},
        {:email, "emma@omise.co"},
        {"bank_account[brand]", "bbl"},
        {"bank_account[number]", "1234567890"},
        {"bank_account[name]", "Emma Stone"}
      ]
  end

  test "normalize recipient params without bank_account key" do
    params = [
      name: "Emma Stone",
      email: "emma@omise.co",
    ]

    assert Utils.normalize_recipient_params(params) ==
      [
        {:name, "Emma Stone"},
        {:email, "emma@omise.co"},
      ]
  end

  test "normalize search params" do
    params = [
      query: "elixir",
      filters: [amount: 1000, paid: true]
    ]

    assert Utils.normalize_search_params(params) ==
      [
        {:query, "elixir"},
        {"filters[amount]", 1000},
        {"filters[paid]", true},
      ]
  end

  test "normalize search params without filters key" do
    params = [
      query: "elixir",
      scope: "customer"
    ]

    assert Utils.normalize_search_params(params) ==
      [
        {:query, "elixir"},
        {:scope, "customer"},
      ]
  end
end
