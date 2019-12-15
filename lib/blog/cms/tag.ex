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
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

  @doc false
  def create_changeset(tag, attrs) do
    tag
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> generate_slug()
    |> unique_constraint(:slug)
  end

  defp generate_slug(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, title} -> put_change(changeset, :slug, slugify(title))
      :error -> changeset
    end
  end

  defp slugify(title \\ "") do
    title
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end
