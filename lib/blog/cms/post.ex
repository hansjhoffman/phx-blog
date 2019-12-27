defmodule Blog.CMS.Post do
  @moduledoc """
  Schema for a blog post
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Accounts.User
  alias Blog.CMS.{StringGenerator, Tag}

  schema "posts" do
    field :content, :string
    field :excerpt, :string
    field :slug, :string
    field :status, :string
    field :title, :string
    field :views, :integer

    belongs_to :user, User
    many_to_many :tags, Tag, join_through: "posts_tags"

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :excerpt, :status, :title])
    |> validate_required([:content, :excerpt, :status, :title])
    |> validate_inclusion(:status, ["ARCHIVED", "DRAFT", "PUBLISHED"])
  end

  @doc false
  def create_changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :excerpt, :title])
    |> validate_required([:content, :excerpt, :title])
    |> generate_slug()
    |> unique_constraint(:slug)
    |> foreign_key_constraint(:user_id)
  end

  defp generate_slug(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, _title} -> put_change(changeset, :slug, StringGenerator.unique_string(10))
      :error -> changeset
    end
  end
end
