defmodule BlogWeb.TagControllerTest do
  use BlogWeb.ConnCase
  import Blog.Factory

  test "GET /tags/:slug", %{conn: conn} do
    tag = insert(:tag)

    conn = get(conn, Routes.tag_path(conn, :index, tag))

    assert html_response(conn, 200) =~ "Posts with tag: #{tag.slug}"
  end
end
