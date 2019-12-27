defmodule BlogWeb.CourseControllerTest do
  use BlogWeb.ConnCase

  test "GET /courses", %{conn: conn} do
    conn = get(conn, Routes.course_path(conn, :index))

    assert html_response(conn, 200) =~ "Courses"
  end
end
