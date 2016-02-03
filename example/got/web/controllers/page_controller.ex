defmodule GOT.PageController do
  use GOT.Web, :controller

  @omise_api Application.get_env(:got, :omise_api)

  def index(conn, _params) do
    render conn, "index.html"
  end

  def donate(conn, %{"omise_token" => card, "donate" => %{"house" => house, "amount" => amount}}) do
    description = "Donate to #{house}"
    response = @omise_api.create_charge(card: card, amount: amount, description: description)
    conn = case response do
      {:ok, charge}  ->
        if charge.paid do
          put_flash(conn, :info, "Thanks for donating!")
        else
          put_flash(conn, :error, charge.failure_message || "Something went wrong :(")
        end
      {:error, error} -> put_flash(conn, :error, error.message)
    end
    redirect(conn, to: page_path(conn, :index))
  end
end
