defmodule Omise.AccountsTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "retrieve the account" do
    with_mock_request "account_retrieve", fn ->
      {:ok, account} = Omise.Accounts.retrieve

      assert account.id
      assert account.email
      assert account.created
    end
  end
end
