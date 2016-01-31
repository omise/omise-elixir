defmodule GOT.PageControllerTest do
  use GOT.ConnCase

  setup_all do
    donate_params = [omise_token: "1234", donate: %{"house" => "house_stark", "amount" => "1000_00"}]

    {:ok, donate_params: donate_params}
  end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Game of Thrones"
    assert html_response(conn, 200) =~ "Donate to the noble house you love."
  end

  test "POST /donate", %{conn: conn, donate_params: donate_params} do
    get conn, "/"
    conn = post conn, "/donate", donate_params
    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "Thanks for donating!"
  end
end
