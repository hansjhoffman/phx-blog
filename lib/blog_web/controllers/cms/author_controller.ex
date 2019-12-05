defmodule BlogWeb.CMS.AuthorController do
  use BlogWeb, :controller

  alias Blog.CMS
  alias Blog.CMS.Author
  alias Blog.Accounts.User

  def index(conn, _params) do
    authors = CMS.list_authors()

    render(conn, "index.html", authors: authors)
  end

  def new(conn, _params) do
    changeset = CMS.change_author(%Author{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"author" => author_params}) do
    case CMS.create_author(author_params) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.cms_author_path(conn, :show, author))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    author = CMS.get_author!(id)

    render(conn, "show.html", author: author)
  end

  def edit(conn, %{"id" => id}) do
    author = CMS.get_author!(id)
    changeset = CMS.change_author(author)

    render(conn, "edit.html", author: author, changeset: changeset)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = CMS.get_author!(id)

    case CMS.update_author(author, author_params) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.cms_author_path(conn, :show, author))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", author: author, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Accounts.get_author!(id)
    {:ok, _author} = Accounts.delete_author(author)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.cms_author_path(conn, :index))
  end
end
