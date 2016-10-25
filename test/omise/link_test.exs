defmodule Omise.LinkTest do
  use ExUnit.Case
  import TestHelper

  @link_id "link_test_55s7xparb9djkecqkd4"

  test "list all links" do
    with_mock_request "links-get", fn ->
      {:ok, list} = Omise.Link.list

      assert %Omise.List{data: links} = list
      assert list.object == "list"
      assert list.from
      assert list.to
      assert list.offset
      assert list.limit
      assert list.total
      assert is_list(links)

      Enum.each links, fn(link) ->
        assert %Omise.Link{} = link
        assert link.object == "link"
        assert %Omise.List{data: charges} = link.charges
        assert is_list(charges)
      end
    end
  end

  test "retrieve a link" do
    with_mock_request "links/#{@link_id}-get", fn ->
      {:ok, link} = Omise.Link.retrieve(@link_id)

      assert %Omise.Link{} = link
      assert link.object == "link"
      assert link.id
      assert link.location
      assert link.amount
      assert link.currency
      refute link.used
      refute link.multiple
      assert link.title
      assert link.description
      assert is_list(link.charges.data)
      assert link.payment_uri
      assert link.created
    end
  end

  test "create a link" do
    with_mock_request "links-post", fn ->
      {:ok, link} = Omise.Link.create(
        amount: 1000_00,
        currency: "thb",
        title: "Awesome Elixir",
        description: "This book will teach you about Elixir Programming Language"
      )

      assert %Omise.Link{} = link
      assert link.object == "link"
      assert link.id
      assert link.location
      assert link.amount == 1000_00
      assert link.currency == "thb"
      refute link.used
      refute link.multiple
      assert link.title
      assert link.description
      assert is_list(link.charges.data)
      assert link.payment_uri
      assert link.created
    end
  end
end
