defmodule Omise.ForexTest do
  use Omise.TestCase

  it "can retrieve the forex", via: "forex/usd" do
    {:ok, forex} = Omise.Forex.retrieve("usd")

    assert forex.object == "forex"
    assert forex.from == "usd"
    assert forex.to == "thb"
    assert is_float(forex.rate)
  end
end
