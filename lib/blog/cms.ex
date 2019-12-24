defmodule Blog.CMS do
  @moduledoc """
  The CMS context.
  """

  import Ecto.Query, warn: false

  alias Blog.Accounts.User
  alias Blog.CMS.{Post, Tag}
  alias Blog.Repo

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    query =
      from p in Post,
        preload: [:user, :tags],
        order_by: [desc: :inserted_at]

    Repo.all(query)
  end

  def get_posts_by_tag_slug(slug) do
    query =
      from p in Post,
        join: t in assoc(p, :tags),
        where: t.slug == ^slug,
        order_by: [asc: :inserted_at]

    Repo.all(query)
  end

  def get_most_viewed_posts(limit) do
    query = 
      from p in Post,
        order_by: [desc: :views],
        limit: ^limit

    Repo.all(query)
  end

  # All featured posts, all with given status
  # def get_all_by() do
  #
  # end

  @doc """
  Gets a single post by: id, title or slug.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_by!(Post, slug: "61e2f0db67")
      %Post{}

      iex> get_by!(Post, id: 42)
      ** (Ecto.NoResultsError)

  """
  def get_by!(Post, params) do
    Post
    |> Repo.get_by!(params)
    |> Repo.preload(:user)
    |> Repo.preload(:tags)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(%User{} = user, attrs \\ %{}) do
    %Post{}
    |> Post.create_changeset(attrs)
    |> Ecto.Changeset.put_change(:user_id, user.id)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  @doc """
  Increments the numbers of views on a given post
  """
  def inc_post_views(%Post{} = post) do
    {1, [%Post{views: views}]} =
      from(p in Post, where: p.id == ^post.id, select: [:views])
      |> Repo.update_all(inc: [views: 1])

    put_in(post.views, views)
  end

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag by: id, slug.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_by!(Tag, slug: "elm")
      %Tag{}

      iex> get_by!(Tag, id: 42)
      ** (Ecto.NoResultsError)

  """
  def get_by!(Tag, params) do
    Tag
    |> Repo.get_by!(params)
  end

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}

  """
  def change_tag(%Tag{} = tag) do
    Tag.changeset(tag, %{})
  end
end
