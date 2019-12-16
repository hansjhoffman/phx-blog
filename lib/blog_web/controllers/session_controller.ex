defmodule BlogWeb.SessionController do
  use BlogWeb, :controller

  alias Blog.Accounts
  alias BlogWeb.Authorizer

  def new(conn, _params) do
    case Authorizer.signed_in?(conn) do
      nil ->
        render(conn, "new.html")

      _user ->
        conn
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))
    end
  end

  def create(conn, %{"session" => %{"handle" => handle, "password" => given_pwd}}) do
    case Accounts.authenticate_by_username_password(handle, given_pwd) do
      {:ok, user} ->
        conn
        |> Authorizer.login(user)
        |> put_flash(:info, "Welcome back #{user.handle}!")
        |> redirect(to: Routes.admin_dashboard_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Authorizer.logout()
    |> redirect(to: Routes.sign_in_path(conn, :new))
  end
end
