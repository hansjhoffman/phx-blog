defmodule BlogWeb.BlogController do
  use BlogWeb, :controller

  alias Blog.CMS

  def index(conn, _params) do
    posts = CMS.all_published_posts()

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    [slug | _] = titled_slug |> String.split("-")

    # post = CMS.get_post_by!(slug: slug) |> CMS.inc_post_views()
    post = CMS.get_post_by!(slug: slug)

    render(conn, "show.html", post: post)
  end
end
