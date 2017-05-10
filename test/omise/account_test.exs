defmodule Omise.AccountTest do
  use ExUnit.Case
  import TestHelper

  test "retrieve the account" do
    with_mock_request "account-get", fn ->
      {:ok, account} = Omise.Account.retrieve

      assert %Omise.Account{} = account
      assert account.object == "account"
      assert account.id
      assert account.location
      assert account.email
      assert account.currency
      assert account.created
    end
  end
end
