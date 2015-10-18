defmodule Omise.RecipientsTest do
  use ExUnit.Case, async: true

  setup do
    params = %{
      name: "James Smith",
      email: "test_recp123@localhost",
      description: "Move on",
      type: "individual",
      bank_account: %{
        brand: "bbl",
        number: "acc12345",
        name: "James Smith"
      }
    }

    {:ok, [params: params]}
  end

  test "list all recipients" do
    {:ok, recipients} = Omise.Recipients.list

    assert is_list recipients["data"]
  end

  test "create a recipient", %{params: params} do
    {:ok, recipient} = Omise.Recipients.create(params)

    assert recipient["object"] == "recipient"
    assert recipient["bank_account"] != nil
  end

  test "destroy a recipient", %{params: params} do
    {:ok, recipient} = Omise.Recipients.create(params)
    {:ok, data} = Omise.Recipients.destroy(recipient["id"])

    assert data["deleted"] == true
  end
end
