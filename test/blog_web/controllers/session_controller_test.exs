defmodule BlogWeb.SessionControllerTest do
  use BlogWeb.ConnCase
  import Blog.Factory

  alias BlogWeb.Authorizer

  setup do
    user = insert(:user)

    {:ok, user: user}
  end

  test "should redirect if user is already authenticated", %{conn: conn, user: user} do
    conn =
      conn
      |> assign(:current_user, user)
      |> get(Routes.sign_in_path(conn, :new))

    assert redirected_to(conn) == Routes.admin_dashboard_path(conn, :index)
  end

  test "logs a user out", %{conn: conn, user: user} do
    conn = 
      conn
      |> assign(:current_user, user)
      |> delete(conn, Routes.sign_out_path(conn, :delete))

    assert redirected_to(conn) == Routes.sign_in_path(conn, :new)
  end
end
