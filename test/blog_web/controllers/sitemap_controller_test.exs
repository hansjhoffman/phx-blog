defmodule BlogWeb.SitemapControllerTest do
  use BlogWeb.ConnCase
  import Blog.Factory

  test "GET /sitemap.xml", %{conn: conn} do
    post = insert(:post, status: "PUBLISHED")

    conn = get(conn, Routes.sitemap_path(conn, :index))

    assert response_content_type(conn, :xml)
    assert response(conn, 200) =~ ~r/<loc>.*#{post.slug}<\/loc>/
  end
end
