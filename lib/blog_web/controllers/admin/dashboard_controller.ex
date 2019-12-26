defmodule BlogWeb.Admin.DashboardController do
  use BlogWeb, :controller
  alias Blog.CMS

  def index(conn, _params) do
    posts = CMS.most_viewed_posts()

    render(conn, "index.html", posts: posts)
  end
end
