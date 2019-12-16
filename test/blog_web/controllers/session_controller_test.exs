defmodule BlogWeb.SessionControllerTest do
  use BlogWeb.ConnCase

  test "GET /in/new", %{conn: conn} do
    conn = get(conn, "/in/new")

    assert html_response(conn, 200) =~ "Sign in"
  end
end
