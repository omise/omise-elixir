defmodule GOT.PageController do
  use GOT.Web, :controller

  @omise_api Application.get_env(:got, :omise_api)

  def index(conn, _params) do
    render conn, "index.html"
  end

  def donate(conn, params) do
    params
    |> build_charge_params
    |> @omise_api.create_charge
    |> handle_response(conn)
    |> redirect(to: page_path(conn, :index))
  end

  defp build_charge_params(%{"omise_token" => card, "donate" => %{"house" => house, "amount" => amount}}),
    do: [card: card, amount: amount, description: "Donate to #{house}"]

  defp handle_response({:ok, charge}, conn) do
    cond do
      charge.paid -> put_flash(conn, :info, "Thanks for donating!")
      true        -> put_flash(conn, :error, charge.failure_message || "Something went wrong :(")
    end
  end
  defp handle_response({:error, error}, conn) do
    put_flash(conn, :error, error.message)
  end
end
