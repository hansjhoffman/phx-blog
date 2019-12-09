defmodule Blog.CMS.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Accounts.User
  alias Blog.CMS.Tag

  schema "posts" do
    field :content, :string
    field :excerpt, :string
    field :slug, :string
    field :title, :string

    belongs_to :user, User
    many_to_many :tags, Tag, join_through: "posts_tags"

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :excerpt, :slug, :title])
    |> validate_required([:content, :excerpt, :slug, :title])
    |> unique_constraint(:slug)
    |> foreign_key_constraint(:user_id)
  end
end
