defmodule Omise.RecipientTest do
  use Omise.TestCase

  it "can list all recipients", via: "recipients-get" do
    {:ok, list} = Omise.Recipient.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "recipient"))
  end

  it "can retrieve the recipient", via: "recipients/recp_test_50894vc13y8z4v51iuc-get" do
    {:ok, recipient} = Omise.Recipient.retrieve("recp_test_50894vc13y8z4v51iuc")

    assert recipient.object == "recipient"
    assert recipient.id == "recp_test_50894vc13y8z4v51iuc"
    assert recipient.bank_account.object == "bank_account"
  end

  it "can create a recipient", via: "recipients-post" do
    {:ok, recipient} = Omise.Recipient.create(
      name:        "John Doe",
      email:       "john.doe@example.com",
      description: "Default recipient",
      type:        "individual",
      bank_account: [
        brand:  "test",
        number: "123456789",
        name:   "JOHN DOE"
      ]
    )

    assert recipient.object == "recipient"
    assert recipient.bank_account.object == "bank_account"
  end

  it "can update the recipient", via: "recipients/recp_test_50894vc13y8z4v51iuc-patch" do
    {:ok, recipient} = Omise.Recipient.update("recp_test_50894vc13y8z4v51iuc", description: "New descripition")

    assert recipient.object == "recipient"
    assert recipient.description == "New description"
  end

  it "can destroy the recipient", via: "recipients/recp_test_50894vc13y8z4v51iuc-delete" do
    {:ok, recipient} = Omise.Recipient.destroy("recp_test_50894vc13y8z4v51iuc")

    assert recipient.object == "recipient"
    assert recipient.deleted
  end

  it "can search for recipients", via: "search-recipient-get" do
    {:ok, search} = Omise.Recipient.search(filters: [kind: "individual"])

    assert search.object == "search"
    assert search.scope == "recipient"
    assert search.query == ""
    assert search.filters == %{"kind" => "individual"}
    assert is_list(search.data)
  end

  it "can list all schedules", via: "recipients/recp_test_50894vc13y8z4v51iuc/schedules-get" do
    {:ok, list} = Omise.Recipient.list_schedules("recp_test_50894vc13y8z4v51iuc")

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "schedule"))
  end
end
