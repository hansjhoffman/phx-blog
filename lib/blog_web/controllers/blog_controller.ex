defmodule BlogWeb.BlogController do
  use BlogWeb, :controller

  alias Blog.CMS
  alias Blog.CMS.Post

  def index(conn, _params) do
    posts = CMS.list_posts()

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    [slug | _] = titled_slug |> String.split("-")

    post = CMS.get_by!(Post, slug: slug)

    render(conn, "show.html", post: post)
  end
end
