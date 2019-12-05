defmodule Blog.CMSTest do
  use Blog.DataCase

  alias Blog.CMS

  describe "posts" do
    alias Blog.CMS.Post

    @valid_attrs %{
      content: "some content",
      excerpt: "some excerpt",
      slug: "some slug",
      title: "some title",
      views: 42
    }
    @update_attrs %{
      content: "some updated content",
      excerpt: "some updated excerpt",
      slug: "some updated slug",
      title: "some updated title",
      views: 43
    }
    @invalid_attrs %{content: nil, excerpt: nil, slug: nil, title: nil, views: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert CMS.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert CMS.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = CMS.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.excerpt == "some excerpt"
      assert post.slug == "some slug"
      assert post.title == "some title"
      assert post.views == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = CMS.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.excerpt == "some updated excerpt"
      assert post.slug == "some updated slug"
      assert post.title == "some updated title"
      assert post.views == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_post(post, @invalid_attrs)
      assert post == CMS.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = CMS.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = CMS.change_post(post)
    end
  end

  describe "authors" do
    alias Blog.CMS.Author

    @valid_attrs %{bio: "some bio", role: "some role"}
    @update_attrs %{bio: "some updated bio", role: "some updated role"}
    @invalid_attrs %{bio: nil, role: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert CMS.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert CMS.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = CMS.create_author(@valid_attrs)
      assert author.bio == "some bio"
      assert author.role == "some role"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, %Author{} = author} = CMS.update_author(author, @update_attrs)
      assert author.bio == "some updated bio"
      assert author.role == "some updated role"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_author(author, @invalid_attrs)
      assert author == CMS.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = CMS.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = CMS.change_author(author)
    end
  end

  describe "tags" do
    alias Blog.CMS.Tag

    @valid_attrs %{slug: "some slug", title: "some title"}
    @update_attrs %{slug: "some updated slug", title: "some updated title"}
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
      assert CMS.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = CMS.create_tag(@valid_attrs)
      assert tag.slug == "some slug"
      assert tag.title == "some title"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = CMS.update_tag(tag, @update_attrs)
      assert tag.slug == "some updated slug"
      assert tag.title == "some updated title"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_tag(tag, @invalid_attrs)
      assert tag == CMS.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = CMS.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = CMS.change_tag(tag)
    end
  end
end
