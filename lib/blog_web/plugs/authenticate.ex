defmodule BlogWeb.Plug.Authenticate do
  import Plug.Conn

  alias Blog.Accounts.User

  def init(opts), do: Keyword.fetch!(opts, :repo)

  def call(conn, repo) do
    user_id = get_session(conn, "id")

    cond do
      user = conn.assigns[:current_user] -> assign(conn, :current_user, user)
      user = user_id && repo.get(User, user_id) -> assign(conn, :current_user, user)
      true -> assign(conn, :current_user, nil)
    end
  end
end
