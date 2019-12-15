defmodule BlogWeb.TagController do
  use BlogWeb, :controller

  alias Blog.CMS

  def index(conn, %{"slug" => slug}) do
    posts = CMS.get_posts_by_tag_slug(slug)

    render(conn, "index.html", posts: posts)
  end
end
