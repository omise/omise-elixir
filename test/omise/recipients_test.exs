defmodule Omise.RecipientsTest do
  use ExUnit.Case, async: false

  import TestHelper

  test "list all recipients" do
    with_mock_request "recipients_list", fn ->
      {:ok, recipients} = Omise.Recipients.list

      assert is_list(recipients[:data])
    end
  end

  test "retrieve a recipient" do
    with_mock_request "recipient_retrieve", fn ->
      {:ok, recipient} = Omise.Recipients.retrieve("recp_test_52olwbmurp6nwkc5ig6")

      assert recipient.id == "recp_test_52olwbmurp6nwkc5ig6"
      assert recipient.location
      assert recipient.verified
      assert recipient.active
      assert recipient.name
      assert recipient.email
      assert recipient.description
      assert recipient.type
      assert recipient.tax_id
      assert recipient.bank_account
      assert recipient.created
    end
  end

  test "create a recipient" do
    with_mock_request "recipient_create", fn ->
      params = [
        name: "Edward Elric",
        email: "test_recp123@email.com",
        description: "Move on",
        type: "individual",
        bank_account: [
          brand: "bbl",
          number: "1234567890",
          name: "Edward Elric"
        ]
      ]
      {:ok, recipient} = Omise.Recipients.create(params)

      assert recipient.location
      refute recipient.verified
      refute recipient.active
      assert recipient.name
      assert recipient.email
      assert recipient.description
      assert recipient.type
      assert recipient.bank_account
      assert recipient.created
    end
  end

  test "destroy a recipient" do
    with_mock_request "recipient_destroy", fn ->
      {:ok, deleted_recipient} = Omise.Recipients.destroy("recp_test_52pe2zrremcckpx8f1g")

      assert deleted_recipient.deleted == true
    end
  end
end
