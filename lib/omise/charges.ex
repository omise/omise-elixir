defmodule Omise.Charges do
  @endpoint "charges"

  def list do
    Omise.process_url(@endpoint)
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end
end
