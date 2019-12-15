defmodule BlogWeb.TagView do
  use BlogWeb, :public_view

  def tag_slug(conn) do
    %{"slug" => slug} = conn.params

    slug
  end
end
