defmodule Blog.CMSTest do
  use Blog.DataCase

  alias Blog.CMS

  describe "posts" do
    alias Blog.Accounts
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

    setup do
      with {:ok, user} <- Accounts.create_user(%{handle: "foobar", password: "123456"}),
           {:ok, post} <- CMS.create_post(user, @valid_attrs) do
        loaded_post = CMS.get_post_by!(%{id: post.id})

        {:ok, post: loaded_post, user: user}
      end
    end

    test "all_posts/0 returns all posts", %{post: post} do
      assert CMS.all_posts() == [post]
    end

    test "get_post!/1 returns the post with given id", %{post: post} do
      assert CMS.get_post_by!(id: post.id) == post
    end

    test "create_post/1 with valid data creates a post", %{post: post} do
      assert post.content == Map.get(@valid_attrs, :content)
      assert post.excerpt == Map.get(@valid_attrs, :excerpt)
      assert post.status == "DRAFT"
      assert post.title == Map.get(@valid_attrs, :title)
      assert post.views == 0
    end

    test "create_post/1 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = CMS.create_post(user, @invalid_attrs)
    end

    test "update_post/2 with valid data updates the post", %{post: post} do
      assert {:ok, %Post{} = post} = CMS.update_post(post, @update_attrs)
      assert post.content == Map.get(@update_attrs, :content)
      assert post.excerpt == Map.get(@update_attrs, :excerpt)
      assert post.title == Map.get(@update_attrs, :title)
    end

    test "update_post/2 with invalid data returns error changeset", %{post: post} do
      assert {:error, %Ecto.Changeset{}} = CMS.update_post(post, @invalid_attrs)
      assert post == CMS.get_post_by!(id: post.id)
    end

    test "delete_post/1 deletes the post", %{post: post} do
      assert {:ok, %Post{}} = CMS.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_post_by!(id: post.id) end
    end

    test "change_post/1 returns a post changeset", %{post: post} do
      assert %Ecto.Changeset{} = CMS.change_post(post)
    end
  end

  describe "tags" do
    alias Blog.CMS.Tag

    @valid_attrs %{slug: "some-title", title: "some title"}
    @update_attrs %{slug: "some-updated-title", title: "some updated title"}
    @invalid_attrs %{slug: nil, title: nil}

    setup do
      with {:ok, tag} <- CMS.create_tag(@valid_attrs) do
        {:ok, tag: tag}
      end
    end

    test "create_tag/1 with valid data creates a tag", %{tag: tag} do
      assert tag.slug == Map.get(@valid_attrs, :slug)
      assert tag.title == Map.get(@valid_attrs, :title)
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_tag(@invalid_attrs)
    end

    test "list_tags/0 returns all tags", %{tag: tag} do
      assert CMS.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id", %{tag: tag} do
      assert CMS.get_tag_by!(id: tag.id) == tag
    end

    test "update_tag/2 with valid data updates the tag", %{tag: tag} do
      assert {:ok, %Tag{} = tag} = CMS.update_tag(tag, @update_attrs)
      assert tag.title == Map.get(@update_attrs, :title)
    end

    test "update_tag/2 with invalid data returns error changeset", %{tag: tag} do
      assert {:error, %Ecto.Changeset{}} = CMS.update_tag(tag, @invalid_attrs)
      assert tag == CMS.get_tag_by!(id: tag.id)
    end

    test "delete_tag/1 deletes the tag", %{tag: tag} do
      assert {:ok, %Tag{}} = CMS.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_tag_by!(id: tag.id) end
    end

    test "change_tag/1 returns a tag changeset", %{tag: tag} do
      assert %Ecto.Changeset{} = CMS.change_tag(tag)
    end
  end
end
