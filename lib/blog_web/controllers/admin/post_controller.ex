defmodule BlogWeb.Admin.PostController do
  use BlogWeb, :controller

  alias Blog.CMS
  alias Blog.CMS.Post

  defp get_post(titled_slug) do
    [slug | _] = titled_slug |> String.split("-")

    CMS.get_by!(Post, slug: slug)
  end

  def create(conn, %{"post" => post_params}) do
    user = conn.assigns.current_user

    case CMS.create_post(user, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.admin_post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"titled_slug" => titled_slug}) do
    post = get_post(titled_slug)
    {:ok, _post} = CMS.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.admin_post_path(conn, :index))
  end

  def edit(conn, %{"titled_slug" => titled_slug}) do
    post = get_post(titled_slug)
    changeset = CMS.change_post(post)

    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def index(conn, _params) do
    posts = CMS.list_posts()

    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = CMS.change_post(%Post{})

    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"titled_slug" => titled_slug}) do
    post = get_post(titled_slug)

    render(conn, "show.html", post: post)
  end

  def update(conn, %{"titled_slug" => titled_slug, "post" => post_params}) do
    post = get_post(titled_slug)

    case CMS.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.admin_post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end
end
