defmodule BlogWeb.SitemapController do
  use BlogWeb, :controller
  alias Blog.CMS

  def index(conn, _params) do
    posts = CMS.all_published_posts()

    conn
    |> render("index.xml", posts: posts)
  end
end
