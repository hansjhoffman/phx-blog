defmodule BlogWeb.SessionController do
  use BlogWeb, :controller

  alias Blog.Accounts
  alias BlogWeb.Authorizer

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"handle" => handle, "password" => given_pwd}}) do
    case Accounts.authenticate_by_username_password(handle, given_pwd) do
      {:ok, user} ->
        conn
        |> Authorizer.login(user)
        |> put_flash(:info, "Welcome back #{user.handle}!")
        |> redirect(to: Routes.admin_page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render(conn, "new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Authorizer.logout()
    |> render(conn, "new.html")
  end
end
