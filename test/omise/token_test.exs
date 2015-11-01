defmodule Omise.TokenTest do
  use ExUnit.Case, async: true

  setup do
    params = [
      name: "Edward Elric",
      city: "Bangkok",
      postal_code: 10320,
      number: 4242424242424242,
      security_code: 123,
      expiration_month: 10,
      expiration_year: 2019
    ]

    {:ok, [params: params]}
  end

  test "that token can be created", %{params: params} do
    {:ok, token} = Omise.Token.create(params)

    assert token["id"] != nil
  end
end
