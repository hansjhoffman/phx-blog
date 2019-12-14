defmodule BlogWeb.Plugs.EnsureAuthenticated do
  @moduledoc """
  Ensures a user is authenticated or redirects to login
  """

  import Plug.Conn
  import Phoenix.Controller

  alias BlogWeb.Router.Helpers, as: Routes

  @doc false
  def init(opts), do: opts

  @doc false
  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.sign_in_path(conn, :new))
      |> halt()
    end
  end
end
