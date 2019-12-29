defmodule BlogWeb.DashboardControllerTest do
  use BlogWeb.ConnCase
  import Blog.Factory

  @tag auth: false
  test "should be redirected when viewing dashboard", %{conn: conn} do
    conn = get(conn, Routes.admin_dashboard_path(conn, :index))

    assert redirected_to(conn) == Routes.sign_in_path(conn, :new)
  end

  @tag auth: true
  test "shoudl view dashboard", %{conn: conn} do
    user = insert(:user)
    conn = assign(conn, :current_user, user)
    response = get(conn, Routes.admin_dashboard_path(conn, :index))

    # assert BlogWeb.Authorizer.signed_in?(conn)
    # assert html_response(conn, 200) =~ "Dashboard"
    # assert redirected_to(conn) == Routes.admin_dashboard_path(conn, :index)
    IO.inspect(response)
  end
end
