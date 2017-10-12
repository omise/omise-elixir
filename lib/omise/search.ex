defmodule Omise.Search do
  @moduledoc ~S"""
  Provides Search API interfaces.

  <https://www.omise.co/search-api>
  """

  use Omise.HTTPClient, endpoint: "search"

  @doc ~S"""
  Retrieve a search data.

  ## Query Parameters:
    * `order` - (optional, default: chronological) The order of the list returned. I.e.: chronological (from earliest to latest), reverse_chronological (from latest to earliest).
    * `scope` - A scope you are searching for I.e. charge, dispute, recipient, and customer.
    * `query` - Searching text within the scope, see more in availble search fields.
    * `filters` - Searching text with specific key within the scope, see more in list of filter keys.
    * `page` - (optional, default: 1) Specific number of searching page.

  ## Examples

      Omise.Search.execute("charge",
        order: "reverse_chronological",
        query: "Elixir",
        filters: [captured: true, amount: 1000]
      )

      Omise.Search.execute("customer",
        query: "Elm",
        filters: [created: "2016-03-15"]
      )

  """
  @spec execute(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def execute(scope, params, options \\ []) do
    params = Omise.Utils.normalize_search_params(params)
    get(@endpoint, Keyword.merge(params, scope: scope), options)
  end
end
