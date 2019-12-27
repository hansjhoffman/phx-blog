defmodule Blog.Factory do
  @moduledoc """
  ExMachina Factory for tests
  """

  use ExMachina.Ecto, repo: Blog.Repo

  alias Blog.Accounts
  alias Blog.CMS.{Post, StringGenerator, Tag}

  def user_factory(attrs) do
    handle = Map.get(attrs, :handle, sequence(:handle, &"foobar#{&1}"))
    password_hash = Pbkdf2.hash_pwd_salt("123456")

    user = %Accounts.User{
      handle: handle,
      password_hash: password_hash
    }

    merge_attributes(user, attrs)
  end

  def post_factory(attrs) do
    content = Map.get(attrs, :content, sequence(:content, &"content#{&1}"))
    excerpt = Map.get(attrs, :excerpt, sequence(:excerpt, &"excerpt#{&1}"))
    slug = Map.get(attrs, :slug, StringGenerator.unique_string())
    status = Map.get(attrs, :status, "DRAFT")
    title = Map.get(attrs, :title, sequence(:title, &"title#{&1}"))
    views = Map.get(attrs, :views, 0)

    post = %Post{
      content: content,
      excerpt: excerpt,
      slug: slug,
      status: status,
      title: title,
      views: views,
      user: build(:user)
    }

    merge_attributes(post, attrs)
  end

  def with_tag(post, tag_name) do
    tag = create(:tag, title: tag_name)
    insert(:post, post: post)
    post
    # create(:post_tag, post: post, tag: tag)
    # post
  end

  def tag_factory(attrs) do
    title = Map.get(attrs, :title, sequence(:title, &"tag#{&1}"))
    slug = Map.get(attrs, :slug, sequence(:slug, &"tag-slug#{&1}"))

    tag = %Tag{
      title: title,
      slug: slug
    }

    merge_attributes(tag, attrs)
  end
end
