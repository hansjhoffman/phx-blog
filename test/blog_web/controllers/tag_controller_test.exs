defmodule BlogWeb.TagControllerTest do
  use BlogWeb.ConnCase

  test "GET /tags/:slug", %{conn: conn} do
    # get posts with that tag
    conn = get(conn, "/tags/elm")

    assert html_response(conn, 200) =~ "Posts with tag: elm"
  end
end
