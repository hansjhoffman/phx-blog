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

  @doc """
  Does current_user have a valid session
  """
  def signed_in?(conn) do
    conn.assigns[:current_user]
  end
end
