defmodule BlogWeb.SitemapController do
  use BlogWeb, :controller
  alias Blog.CMS

  def index(conn, _params) do
    posts = CMS.all_published_posts()

    conn
    |> put_resp_content_type("text/xml")
    |> render("index.xml", posts: posts)
  end
end
