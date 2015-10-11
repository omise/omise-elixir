defmodule Omise.UtilTest do
  use ExUnit.Case, async: true

  test "transform_token_params function" do
    params = %{
      name: "Teerawat",
      city: "Surin",
      postal_code: 32000,
      number: 4242424242424242,
      security_code: 123,
      expiration_month: 12,
      expiration_year: 2020
    }

    expected_params = [
      {"card[city]", "Surin"},
      {"card[expiration_month]", 12},
      {"card[expiration_year]", 2020},
      {"card[name]", "Teerawat"},
      {"card[number]", 4242424242424242},
      {"card[postal_code]", 32000},
      {"card[security_code]", 123},
    ]

    assert Omise.Util.transform_token_params(params) == expected_params
  end
end
