defmodule BlogWeb.Authorizer do
  @moduledoc """
  Provides auth helper functions
  """

  import Plug.Conn

  alias Blog.Accounts

  @doc """
  Logs in the user and puts the user in the conn
  """
  def login(conn, %Accounts.User{} = user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  @doc """
  Logs out the current_user and drops the session
  """
  def logout(conn) do
    conn
    |> configure_session(drop: true)
  end

  def signed_in?(conn) do
    conn.assigns[:current_user]
  end

  @doc """
  Restricts a route or action to logged in users
  """
  # def ensure_authenticated(conn, _opts) do
  #   if conn.assigns.current_user do
  #     conn
  #   else
  #     conn
  #     # |> put_flash(:error, "You must be logged in to access that page")
  #     # |> redirect(to: Routes.session_path(conn, :new))
  #     |> halt()
  #   end
  # end
  # defp authorize_page(conn, _) do
  #   page = CMS.get_page!(conn.params["id"])
  #
  #   if conn.assigns.current_author.id == page.author_id do
  #     assign(conn, :page, page)
  #   else
  #     conn
  #     |> put_flash(:error, "You can't modify that page")
  #     |> redirect(to: Routes.cms_page_path(conn, :index))
  #     |> halt()
  #   end
  # end
end
