defmodule BlogWeb.BlogController do
  use BlogWeb, :controller

  alias Blog.CMS

  def index(conn, _params) do
    posts = CMS.list_posts()

    render(conn, "index.html", posts: posts)
  end

  end
end
