defmodule Omise.RecipientsTest do
  use ExUnit.Case, async: true

  test "list all recipients" do
    {:ok, recipients} = Omise.Recipients.list

    assert is_list recipients["data"]
  end

  test "create a recipient" do
    params = %{
      name: "James Smith",
      email: "test_recp123@localhost",
      description: "Move on",
      type: "individual",
      bank_account: %{
        brand: "bbl",
        number: "acc12345",
        account_name: "James Smith"
      }
    }
    {:ok, recipient} = Omise.Recipients.create(params)

    assert recipient["object"] == "recipient"
    assert recipient["bank_account"] != nil
  end
end
