defmodule BlogWeb.DashboardControllerTest do
  use BlogWeb.ConnCase

  test "[Unauthenticated] GET /admin", %{conn: conn} do
    conn = get(conn, "/admin")

    assert html_response(conn, 302)
  end

  test "[Authenticated] GET /admin", %{conn: conn} do
    conn = get(conn, "/admin")

    assert html_response(conn, 200) =~ "Hello world!"
  end
end
