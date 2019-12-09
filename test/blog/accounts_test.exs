defmodule Blog.AccountsTest do
  use Blog.DataCase

  alias Blog.Accounts

  describe "users" do
    alias Blog.Accounts.User

    @valid_attrs %{handle: "foobar", password: "123456"}
    @update_attrs %{handle: "foobaz", password: "123456"}
    @invalid_attrs %{handle: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      %{user | password: nil}
    end

    test "create_user/1 with valid data creates a user" do
      user = user_fixture()

      assert user.handle == Map.get(@valid_attrs, :handle)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "list_users/0 returns all users" do
      user = user_fixture()

      assert Accounts.list_users() == [user]
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()

      assert Accounts.get_user(user.id) == user
    end

    test "get_user_by/1 returns the user with given params" do
      user = user_fixture()

      assert Accounts.get_user_by(handle: user.handle) == user
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      assert user.handle != Map.get(@update_attrs, :handle)
      assert {:ok, %User{} = updated_user} = Accounts.update_user(user, @update_attrs)
      assert updated_user.handle == Map.get(@update_attrs, :handle)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()

      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()

      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert Accounts.get_user(user.id) == nil
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()

      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
