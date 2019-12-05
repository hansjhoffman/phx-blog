defmodule Blog.CMS.Author do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Accounts.User
  alias Blog.CMS.Post

  schema "authors" do
    field :bio, :string
    field :role, :string
    has_many :posts, Post
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:bio, :role])
    |> validate_required([:role])
    |> unique_constraint(:user_id)
  end
end
