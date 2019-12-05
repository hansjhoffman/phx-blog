defmodule BlogWeb.CMS.PostController do
  use BlogWeb, :controller

  alias Blog.CMS
  alias Blog.CMS.Post

  def create(conn, %{"post" => post_params}) do
    case CMS.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.cms_post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = CMS.get_post!(id)
    {:ok, _post} = CMS.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.cms_post_path(conn, :index))
  end

  def edit(conn, %{"id" => id}) do
    post = CMS.get_post!(id)
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

  def show(conn, %{"id" => id}) do
    post = CMS.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = CMS.get_post!(id)

    case CMS.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.cms_post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end
end
