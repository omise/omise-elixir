defmodule Omise.Customers do
  @endpoint "customers"

  def list do
    Omise.process_url(@endpoint)
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  def get(id) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.get(Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  def create(%{email: email, description: description, card: card}) do
    Omise.process_url(@endpoint)
      |> HTTPoison.post({:form, [email: email, description: description, card: card]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  def create(%{email: email, description: description}) do
    Omise.process_url(@endpoint)
      |> HTTPoison.post({:form, [email: email, description: description]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  def update(id, %{card: card}) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.patch({:form, [card: card]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  def update(id, %{email: email, description: description}) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.patch({:form, [email: email, description: description]}, Omise.req_headers, Omise.auth)
      |> Omise.Util.handle_response
  end

  def delete(id) do
    Omise.process_url("#{@endpoint}/#{id}")
      |> HTTPoison.delete(Omise.req_headers)
      |> Omise.Util.handle_response
  end
end
