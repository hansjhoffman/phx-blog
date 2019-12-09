defmodule BlogWeb.Plugs.EnsureAuthenticated do
  import Plug.Conn
  # import Phoenix.Controller

  @doc false
  def init(opts), do: opts

  @doc false
  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      # |> put_flash(:error, "You must be logged in to access that page")
      # |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end
