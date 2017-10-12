defmodule Omise.AccountTest do
  use Omise.TestCase

  it "can retrieve the account", via: "account-get" do
    {:ok, account} = Omise.Account.retrieve

    assert account.object == "account"
  end
end
