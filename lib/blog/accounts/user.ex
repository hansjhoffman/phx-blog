defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Accounts.Credential
  alias Blog.CMS.Post

  schema "users" do
    field :full_name, :string
    has_one :credential, Credential
    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:full_name])
    |> validate_required([:full_name])
  end
end
