defmodule BlogWeb.BlogControllerTest do
  use BlogWeb.ConnCase
  import Blog.Factory

  alias Blog.CMS
  alias BlogWeb.Helpers.SharedHelpers

  test "GET /blog", %{conn: conn} do
    posts = insert_pair(:post, status: "PUBLISHED")

    conn = get(conn, Routes.blog_path(conn, :index))

    for post <- posts do
      assert html_response(conn, 200) =~ post.title
    end
  end

  test "GET /blog/:titled_slug", %{conn: conn} do
    post = insert(:post)
    titled_slug = "#{post.slug}-#{SharedHelpers.slugify(post.title)}"

    conn = get(conn, Routes.post_path(conn, :show, titled_slug))

    assert html_response(conn, 200) =~ post.title
    assert html_response(conn, 200) =~ post.content
    assert CMS.get_post_by!(id: post.id).views == 1
  end
end
