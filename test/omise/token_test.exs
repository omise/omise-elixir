defmodule Omise.TokenTest do
  use Omise.TestCase

  it "can create a token", via: "tokens-post" do
    {:ok, token} = Omise.Token.create(
      card: [
        name:             "Ash",
        city:             "Bangkok",
        postal_code:      "10320",
        number:           4242424242424242,
        security_code:    123,
        expiration_month: 10,
        expiration_year:  2019
      ]
    )

    assert token.object == "token"
  end

  it "can retrieve the token", via: "tokens/tokn_test_12p4j8aeb6x1v7mk63x-get" do
    {:ok, token} = Omise.Token.retrieve("tokn_test_12p4j8aeb6x1v7mk63x")

    assert token.object == "token"
    assert token.id == "tokn_test_12p4j8aeb6x1v7mk63x"
  end
end
