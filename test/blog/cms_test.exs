defmodule Blog.CMSTest do
  use Blog.DataCase

  alias Blog.{Accounts, CMS}

  describe "posts" do
    alias Blog.CMS.Post

    @valid_attrs %{
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

    def user_fixture do
      {:ok, user} = Accounts.create_user(%{handle: "foobar", password: "123456"})

      user
    end

    def post_fixture(attrs \\ %{}) do
      {:ok, post} = CMS.create_post(user_fixture(), attrs |> Enum.into(@valid_attrs))

      post
      |> Repo.preload(:user)
      |> Repo.preload(:tags)
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()

      assert CMS.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()

      assert CMS.get_by!(Post, id: post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = CMS.create_post(user_fixture(), @valid_attrs)

      assert post.content == Map.get(@valid_attrs, :content)
      assert post.excerpt == Map.get(@valid_attrs, :excerpt)
      assert post.title == Map.get(@valid_attrs, :title)
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_post(user_fixture(), @invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      assert {:ok, %Post{} = post} = CMS.update_post(post, @update_attrs)
      assert post.content == Map.get(@update_attrs, :content)
      assert post.excerpt == Map.get(@update_attrs, :excerpt)
      assert post.title == Map.get(@update_attrs, :title)
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()

      assert {:error, %Ecto.Changeset{}} = CMS.update_post(post, @invalid_attrs)
      assert post == CMS.get_by!(Post, id: post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()

      assert {:ok, %Post{}} = CMS.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_by!(Post, id: post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()

      assert %Ecto.Changeset{} = CMS.change_post(post)
    end
  end

  describe "tags" do
    alias Blog.CMS.Tag

    @valid_attrs %{slug: "some-title", title: "some title"}
    @update_attrs %{slug: "some-updated-title", title: "some updated title"}
    @invalid_attrs %{slug: nil, title: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()

      assert CMS.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()

      assert CMS.get_by!(Tag, id: tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = CMS.create_tag(@valid_attrs)
      assert tag.slug == Map.get(@valid_attrs, :slug)
      assert tag.title == Map.get(@valid_attrs, :title)
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()

      assert {:ok, %Tag{} = tag} = CMS.update_tag(tag, @update_attrs)
      assert tag.title == Map.get(@update_attrs, :title)
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()

      assert {:error, %Ecto.Changeset{}} = CMS.update_tag(tag, @invalid_attrs)
      assert tag == CMS.get_by!(Tag, id: tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()

      assert {:ok, %Tag{}} = CMS.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_by!(Tag, id: tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()

      assert %Ecto.Changeset{} = CMS.change_tag(tag)
    end
  end
end
