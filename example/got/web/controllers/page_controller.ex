defmodule GOT.PageController do
  use GOT.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def donate(conn, %{"omise_token" => omise_token, "donate" => donate_params}) do
    response = make_donation(omise_token, donate_params)
    conn = case response do
      {:ok, _charge}  -> put_flash(conn, :info, "Thanks for donating!")
      {:error, error} -> put_flash(conn, :error, error.message)
    end
    redirect(conn, to: page_path(conn, :index))
  end

  defp make_donation(token_id, donate_params) do
    Omise.Charges.create(
      currency: "thb",
      amount: donate_params["amount"],
      description: "Donate to #{donate_params["house"]}",
      card: token_id
    )
  end
end
