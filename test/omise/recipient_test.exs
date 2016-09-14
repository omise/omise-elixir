defmodule Omise.RecipientTest do
  use ExUnit.Case
  import TestHelper

  setup_all do
    recipient_id = "recp_test_50894vc13y8z4v51iuc"

    {:ok, recipient_id: recipient_id}
  end

  test "list all recipients" do
    with_mock_request "recipients-get", fn ->
      {:ok, list} = Omise.Recipient.list

      assert %Omise.List{data: recipients} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(list.data)

      Enum.each recipients, fn(recipient) ->
        assert %Omise.Recipient{} = recipient
        assert recipient.object == "recipient"
      end
    end
  end

  test "retrieve a recipient", %{recipient_id: recipient_id} do
    with_mock_request "recipients/#{recipient_id}-get", fn ->
      {:ok, recipient} = Omise.Recipient.retrieve(recipient_id)

      assert %Omise.Recipient{} = recipient
      assert recipient.object == "recipient"
      assert recipient.id
      assert is_boolean(recipient.livemode)
      assert recipient.location
      assert is_boolean(recipient.verified)
      assert is_boolean(recipient.active)
      assert recipient.name
      assert recipient.email
      assert recipient.description
      assert recipient.type
      assert recipient.tax_id
      assert recipient.bank_account
      refute recipient.failure_code
      assert recipient.created
      refute recipient.deleted

      bank_account = recipient.bank_account
      assert %Omise.ThaiBankAccount{} = bank_account
      assert bank_account.object == "bank_account"
      assert bank_account.brand
      assert bank_account.last_digits
      assert bank_account.name
      assert bank_account.created
    end
  end

  test "create a recipient" do
    with_mock_request "recipients-post", fn ->
      {:ok, recipient} = Omise.Recipient.create(
        name: "john.doe@example.com",
        email: "john.doe@example.com",
        description: "Default recipient",
        type: "individual",
        bank_account: [
          brand: "test",
          number: "123456789",
          name: "JOHN DOE"
        ]
      )

      assert %Omise.Recipient{} = recipient
      assert recipient.object == "recipient"
      assert recipient.name == "john.doe@example.com"

      bank_account = recipient.bank_account
      assert %Omise.ThaiBankAccount{} = bank_account
      assert bank_account.object == "bank_account"
      assert bank_account.brand == "test"
      assert bank_account.last_digits == "6789"
      assert bank_account.name == "JOHN DOE"
      assert bank_account.created
    end
  end

  test "update a recipient", %{recipient_id: recipient_id} do
    with_mock_request "recipients/#{recipient_id}-patch", fn ->
      description = "New description"
      {:ok, recipient} = Omise.Recipient.update(recipient_id, description: description)

      assert %Omise.Recipient{} = recipient
      assert recipient.object == "recipient"
      assert recipient.description == description
      refute recipient.deleted
    end
  end

  test "destroy a recipient", %{recipient_id: recipient_id} do
    with_mock_request "recipients/#{recipient_id}-delete", fn ->
      {:ok, recipient} = Omise.Recipient.destroy(recipient_id)

      assert %Omise.Recipient{} = recipient
      assert recipient.object == "recipient"
      assert recipient.deleted
    end
  end

  test "search recipients" do
    with_mock_request "search-recipient-get", fn ->
      {:ok, search_data} = Omise.Recipient.search(filters: [kind: "individual"])

      assert %Omise.Search{data: data} = search_data
      assert search_data.object == "search"
      assert search_data.scope == "recipient"
      assert search_data.query == ""
      assert search_data.filters == %{"kind" => "individual"}
      assert search_data.page == 1
      assert search_data.total_pages == 1
      assert search_data.total == 1
      assert is_list(data)
      Enum.each data, fn(recipient) ->
        assert recipient.type == "individual"
      end
    end
  end
end
