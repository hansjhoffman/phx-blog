defmodule BlogWeb.Admin.TagControllerTest do
  use BlogWeb.ConnCase

  alias Blog.CMS

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:tag) do
    with {:ok, tag} <- CMS.create_tag(@create_attrs) do
      tag
    end
  end

  describe "index" do
    test "lists all tags", %{conn: conn} do
      conn = get(conn, Routes.admin_tag_path(conn, :index))

      assert html_response(conn, 200) =~ "Listing Tags"
    end
  end

  describe "new tag" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_tag_path(conn, :new))

      assert html_response(conn, 200) =~ "New Tag"
    end
  end

  describe "create tag" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_tag_path(conn, :create), tag: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_tag_path(conn, :show, id)

      conn = get(conn, Routes.admin_tag_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tag"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_tag_path(conn, :create), tag: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Tag"
    end
  end

  describe "edit tag" do
    setup [:create_tag]

    test "renders form for editing chosen tag", %{conn: conn, tag: tag} do
      conn = get(conn, Routes.admin_tag_path(conn, :edit, tag))

      assert html_response(conn, 200) =~ "Edit Tag"
    end
  end

  describe "update tag" do
    setup [:create_tag]

    test "redirects when data is valid", %{conn: conn, tag: tag} do
      conn = put(conn, Routes.admin_tag_path(conn, :update, tag), tag: @update_attrs)
      assert redirected_to(conn) == Routes.admin_tag_path(conn, :show, tag)

      conn = get(conn, Routes.admin_tag_path(conn, :show, tag))
      assert html_response(conn, 200) =~ Map.get(@update_attrs, :slug)
    end

    test "renders errors when data is invalid", %{conn: conn, tag: tag} do
      conn = put(conn, Routes.admin_tag_path(conn, :update, tag), tag: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Tag"
    end
  end

  describe "delete tag" do
    setup [:create_tag]

    test "deletes chosen tag", %{conn: conn, tag: tag} do
      conn = delete(conn, Routes.admin_tag_path(conn, :delete, tag))
      assert redirected_to(conn) == Routes.admin_tag_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.admin_tag_path(conn, :show, tag))
      end
    end
  end

  defp create_tag(_) do
    tag = fixture(:tag)

    {:ok, tag: tag}
  end
end
