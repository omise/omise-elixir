defmodule Omise.Account do
  @moduledoc """
  An API for working with Account at Omise.
  """

  @endpoint "account"

  @doc """
  Retrieve the account.

  ## Example

  ```
    {:ok, account} = Omise.Account.retrieve
  ```

  """
  def retrieve do
    Omise.process_url(@endpoint)
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end
end
