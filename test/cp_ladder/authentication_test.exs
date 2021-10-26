defmodule CpLadder.AuthenticationTest do
  use CpLadder.DataCase

  alias CpLadder.Authentication

  describe "users" do
    alias CpLadder.Authentication.User

    import CpLadder.AuthenticationFixtures

    @invalid_attrs %{email: nil, password_hash: nil}

    test "list_users/0 returns all users" do
      user_fixture()
      assert length(Authentication.list_users()) == 1
    end

    test "get_user!/1 returns the user with given id" do
      email = "hello@world"
      user = user_fixture(%{email: email})
      assert Authentication.get_user!(user.id).email == email
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some@email", password: "helloworld", password_confirmation: "helloworld"}

      {:ok, %User{} = user} = Authentication.create_user(valid_attrs)
      assert user.email == "some@email"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authentication.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "hell@world", password: "helloworld", password_confirmation: "helloworld"}

      {:ok, %User{} = user} = Authentication.update_user(user, update_attrs)
      assert user.email == "hell@world"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Authentication.update_user(user, @invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Authentication.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Authentication.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Authentication.change_user(user)
    end
  end
end
