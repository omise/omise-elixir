defmodule Omise.ForexTest do
  use ExUnit.Case
  import TestHelper

  test "retrieve a forex" do
    with_mock_request "forex/usd", fn ->
      {:ok, forex} = Omise.Forex.retrieve("usd")

      assert %Omise.Forex{} = forex
      assert forex.object == "forex"
      assert forex.from == "usd"
      assert forex.to == "thb"
      assert is_float(forex.rate)
      assert forex.location
    end
  end
end
