defmodule BlogWeb.Admin.PostControllerTest do
  use BlogWeb.ConnCase

  alias Blog.{Accounts, CMS}

  @create_attrs %{
    content: "some content",
    excerpt: "some excerpt",
    title: "some title"
  }
  @update_attrs %{
    content: "some updated content",
    excerpt: "some updated excerpt",
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, excerpt: nil, title: nil}

  def fixture(:post) do
    with {:ok, user} <- Accounts.create_user(%{handle: "foobar", password: "123456"}),
         {:ok, post} <- CMS.create_post(user, @create_attrs) do
      post
    end
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.cms_post_path(conn, :index))

      assert html_response(conn, 200) =~ "Listing Posts"
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.cms_post_path(conn, :new))

      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cms_post_path(conn, :create), post: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.cms_post_path(conn, :show, id)

      conn = get(conn, Routes.cms_post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Post"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cms_post_path(conn, :create), post: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get(conn, Routes.cms_post_path(conn, :edit, post))

      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: conn, post: post} do
      conn = put(conn, Routes.cms_post_path(conn, :update, post), post: @update_attrs)
      assert redirected_to(conn) == Routes.cms_post_path(conn, :show, post)

      conn = get(conn, Routes.cms_post_path(conn, :show, post))
      assert html_response(conn, 200) =~ Map.get(@update_attrs, :content)
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, Routes.cms_post_path(conn, :update, post), post: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.cms_post_path(conn, :delete, post))
      assert redirected_to(conn) == Routes.cms_post_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.cms_post_path(conn, :show, post))
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)

    {:ok, post: post}
  end
end
