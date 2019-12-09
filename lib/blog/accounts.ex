defmodule Blog.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Blog.Accounts.User
  alias Blog.Repo

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    User
    |> Repo.all()
  end

  @doc """
  Gets a single user.

  Returns `nil` if the User does not exist.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      nil

  """
  def get_user(id) do
    User
    |> Repo.get(id)
  end

  @doc """
  Gets a user by the given params.

  ## Examples

      iex> get_user_by(handle: "foobar")
      {:ok, %User{}}
  """
  def get_user_by(params) do
    User
    |> Repo.get_by(params)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Attempts to authenticate a user.

  ## Examples

      iex> authenticate_by_username_password
  """
  def authenticate_by_username_password(username, given_pwd) do
    user = get_user_by(handle: username)

    cond do
      user && Pbkdf2.verify_pass(given_pwd, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      # change this to _ -> ??
      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
