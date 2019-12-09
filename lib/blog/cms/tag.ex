defmodule Blog.CMS.Tag do
  @moduledoc """
  Schema for a tag
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.CMS.Post

  schema "tags" do
    field :slug, :string
    field :title, :string

    many_to_many :posts, Post, join_through: "posts_tags"

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:slug, :title])
    |> validate_required([:slug, :title])
    |> unique_constraint(:slug)
  end
end
