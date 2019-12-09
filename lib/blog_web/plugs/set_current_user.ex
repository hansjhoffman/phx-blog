defmodule BlogWeb.Plugs.SetCurrentUser do
  @moduledoc """
  Attempts to set the @current_user in the conn
  """
  
  import Plug.Conn

  alias Blog.Accounts

  @doc false
  def init(opts), do: opts

  @doc false
  def call(conn, _opts) do
    with user_id <- get_session(conn, "user_id"),
         user <- user_id && Accounts.get_user(user_id) do
      assign(conn, :current_user, user)
    end
  end
end
