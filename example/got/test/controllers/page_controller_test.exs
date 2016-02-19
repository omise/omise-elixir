defmodule GOT.PageControllerTest do
  use GOT.ConnCase

  setup_all do
    valid_donate_params =
      [omise_token: "1234", donate: %{"house" => "house_stark", "amount" => "1000_00"}]
    invalid_donate_params =
      [omise_token: "xxxx", donate: %{"house" => "house_targaryen", "amount" => "500_00"}]

    {:ok,
      valid_donate_params: valid_donate_params,
      invalid_donate_params: invalid_donate_params}
  end

  test "index page", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Game of Thrones"
    assert html_response(conn, 200) =~ "Donate to the noble house you love."
  end

  test "successful donation", %{conn: conn, valid_donate_params: valid_donate_params} do
    get conn, "/"
    conn = post conn, "/donate", valid_donate_params
    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "Thanks for donating!"
  end

  test "failed donation", %{conn: conn, invalid_donate_params: invalid_donate_params} do
    get conn, "/"
    conn = post conn, "/donate", invalid_donate_params
    assert html_response(conn, 302)
    assert get_flash(conn, :error) =~ "failed processing"
  end
end
