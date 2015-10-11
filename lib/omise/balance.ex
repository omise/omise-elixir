defmodule Omise.Balance do
  @moduledoc """
  An API for working with Balance at Omise.
  """

  @endpoint "balance"

  @doc """
  Retrieve the balance.

  ## Example

  ```
    {:ok, balance} = Omise.Balance.retrieve
  ```

  """
  def retrieve do
    Omise.process_url(@endpoint)
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end
end
