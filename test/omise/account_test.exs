defmodule Omise.AccountTest do
  use ExUnit.Case, async: true

  test "that account can be retrieved" do
    {:ok, account} = Omise.Account.retrieve

    assert account["object"] == "account"
  end
end
