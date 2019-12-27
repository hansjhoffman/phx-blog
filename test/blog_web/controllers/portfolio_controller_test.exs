defmodule BlogWeb.PortfolioControllerTest do
  use BlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, Routes.portfolio_path(conn, :index))

    assert html_response(conn, 200) =~ "Portfolio"
  end
end
