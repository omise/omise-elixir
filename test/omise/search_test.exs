defmodule Omise.SearchTest do
  use ExUnit.Case
  import TestHelper

  test "search with scope and " do
    with_mock_request "search-charge-get", fn ->
      {:ok, search_data} =
        Omise.Search.execute("charge", [filters: [amount: 10000, paid: true]])

      assert %Omise.Search{data: data} = search_data
      assert search_data.object == "search"
      assert search_data.scope == "charge"
      assert search_data.query == ""
      assert search_data.filters == %{"amount" => "10000", "paid" => "true"}
      assert search_data.page == 1
      assert search_data.total_pages == 1
      assert search_data.total == 1
      assert is_list(data)
    end
  end
end
