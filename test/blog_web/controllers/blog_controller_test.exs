defmodule BlogWeb.BlogControllerTest do
  use BlogWeb.ConnCase

  test "GET /blog", %{conn: conn} do
    conn = get(conn, "/blog")

    assert html_response(conn, 200) =~ "Sign in"
  end

  test "GET /blog/:slug", %{conn: conn} do
    conn = get(conn, "/blog/27sj4933-first-post")

    assert html_response(conn, 200) =~ "Sign in"
  end
end
