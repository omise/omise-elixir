defmodule Omise.Search do
  @moduledoc ~S"""
  Provides Search API interfaces.

  https://www.omise.co/search-api
  """

  import Omise.HTTP

  defstruct [
    object:      "search",
    location:    nil,
    scope:       nil,
    query:       nil,
    filters:     nil,
    page:        nil,
    total_pages: nil,
    total:       nil,
    data:        []
  ]

  @type t :: %__MODULE__{
    object:      String.t,
    location:    String.t,
    scope:       String.t,
    query:       String.t,
    filters:     map,
    page:        integer,
    total_pages: integer,
    total:       integer,
    data:        list
  }

  @endpoint "search"

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
  @spec execute(String.t, Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def execute(scope, params, opts \\ []) do
    module = Module.concat(Omise, String.capitalize(scope))
    opts   = Keyword.merge(opts, as: %Omise.Search{data: [struct(module)]})

    get(@endpoint, Keyword.merge(params, scope: scope), opts)
  end
end
