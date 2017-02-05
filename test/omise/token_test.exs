defmodule Omise.TokenTest do
  use ExUnit.Case
  import TestHelper

  @token_id "tokn_test_12p4j8aeb6x1v7mk63x"

  test "create a token" do
    with_mock_request "tokens-post", fn ->
      {:ok, token} = Omise.Token.create(
        name: "Halsey",
        city: "Bangkok",
        postal_code: "10320",
        number: 4242424242424242,
        security_code: 123,
        expiration_month: 10,
        expiration_year: 2019
      )

      assert %Omise.Token{} = token
      assert token.object == "token"
    end
  end

  test "retrieve a token" do
    with_mock_request "tokens/#{@token_id}-get", fn ->
      {:ok, token} = Omise.Token.retrieve(@token_id)

      assert %Omise.Token{} = token
      assert token.object == "token"
      assert token.id == @token_id
    end
  end
end
