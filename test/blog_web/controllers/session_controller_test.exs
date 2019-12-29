defmodule BlogWeb.SessionControllerTest do
  use BlogWeb.ConnCase
  import Blog.Factory

  alias BlogWeb.Authorizer

  setup %{conn: conn} do
    user = insert(:user)
    conn = assign(conn, :current_user, user)
    IO.inspect(conn)
    {:ok, conn: conn, user: user}
  end

  test "should redirect if user is already authenticated", %{conn: conn} do
    conn =
      conn
      |> get(conn, Routes.sign_in_path(conn, :new))

    # assert redirected_to(conn) == Routes.admin_dashboard_path(conn, :index)
  end

  test "logs a user out", %{conn: conn, user: user} do
    conn =
      conn
      # |> assign(:current_user, user)
      |> delete(conn, Routes.sign_out_path(conn, :delete))

    assert redirected_to(conn) == Routes.sign_in_path(conn, :new)
    refute Authorizer.signed_in?(conn)
  end
end
