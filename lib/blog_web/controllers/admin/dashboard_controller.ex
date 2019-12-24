defmodule BlogWeb.Admin.DashboardController do
  use BlogWeb, :controller
  alias Blog.CMS

  def index(conn, _params) do
    posts = CMS.get_most_viewed_posts(5)

    render(conn, "index.html", posts: posts)
  end
end
