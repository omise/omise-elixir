defmodule Omise.SearchTest do
  use Omise.TestCase

  it "can search for the data", via: "search-charge-get" do
    {:ok, search} = Omise.Search.execute("charge", [filters: [amount: 10000, paid: true]])

    assert search.object == "search"
    assert search.scope == "charge"
    assert search.query == ""
    assert search.filters == %{"amount" => "10000", "paid" => "true"}
    assert is_list(search.data)
  end
end
