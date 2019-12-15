defmodule BlogWeb.Admin.TagController do
  use BlogWeb, :controller

  alias Blog.CMS
  alias Blog.CMS.Tag

  def index(conn, _params) do
    tags = CMS.list_tags()

    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = CMS.change_tag(%Tag{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case CMS.create_tag(tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag created successfully.")
        |> redirect(to: Routes.admin_tag_path(conn, :show, tag))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    tag = CMS.get_by!(Tag, slug: slug)

    render(conn, "show.html", tag: tag)
  end

  def edit(conn, %{"slug" => slug}) do
    tag = CMS.get_by!(Tag, slug: slug)
    changeset = CMS.change_tag(tag)

    render(conn, "edit.html", tag: tag, changeset: changeset)
  end

  def update(conn, %{"slug" => slug, "tag" => tag_params}) do
    tag = CMS.get_by!(Tag, slug: slug)

    case CMS.update_tag(tag, tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag updated successfully.")
        |> redirect(to: Routes.admin_tag_path(conn, :show, tag))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag: tag, changeset: changeset)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    tag = CMS.get_by!(Tag, slug: slug)
    {:ok, _tag} = CMS.delete_tag(tag)

    conn
    |> put_flash(:info, "Tag deleted successfully.")
    |> redirect(to: Routes.admin_tag_path(conn, :index))
  end
end
