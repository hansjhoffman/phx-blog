defmodule Blog.Accounts.User do
  @moduledoc """
  Schema for system & blog user
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.CMS.Post

  schema "users" do
    field :handle, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:handle])
    |> validate_required([:handle])
    |> validate_length(:handle, min: 1, max: 25)
    |> unique_constraint(:handle)
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:handle, :password])
    |> validate_required([:handle, :password])
    |> validate_length(:handle, min: 1, max: 25)
    |> unique_constraint(:handle)
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pwd}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pwd))

      _ ->
        changeset
    end
  end
end
