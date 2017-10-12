defmodule Omise.LinkTest do
  use Omise.TestCase

  it "can list all links", via: "links-get" do
    {:ok, list} = Omise.Link.list

    assert list.object == "list"
    assert is_list(list.data)
    assert Enum.all?(list.data, &(&1.object == "link"))
  end

  it "can retrieve the link", via: "links/link_test_55s7xparb9djkecqkd4-get" do
    {:ok, link} = Omise.Link.retrieve("link_test_55s7xparb9djkecqkd4")

    assert link.object == "link"
    assert link.id == "link_test_55s7xparb9djkecqkd4"
  end

  it "can create a link", via: "links-post" do
    {:ok, link} = Omise.Link.create(
      amount:      100000,
      currency:    "thb",
      title:       "Awesome Elixir",
      description: "Elixir is awesome."
    )

    assert link.object == "link"
    assert link.amount == 100000
  end
end
