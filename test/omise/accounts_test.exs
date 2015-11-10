defmodule Omise.AccountsTest do
  use ExUnit.Case, async: false

  test "retrieve the account" do
    {:ok, account} = Omise.Accounts.retrieve

    assert %Omise.Account{} = account
  end
end
