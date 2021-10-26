defmodule CpLadderWeb.UserControllerTest do
  use CpLadderWeb.ConnCase

  import CpLadder.AuthenticationFixtures

  alias CpLadder.Guardian
  alias CpLadder.Authentication.User
  alias CpLadder.Authentication

  @create_attrs %{
    email: "some@email",
    password: "password",
    password_confirmation: "password"
  }
  @update_attrs %{
    email: "some updated@email",
    password: "password",
    password_confirmation: "password"
  }
  @invalid_attrs %{email: nil, password_hash: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_user]

    test "lists all users with proper authentication", %{conn: conn, user: user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      authenticated_connection =
        build_conn()
        |> put_req_header("authorization", "Bearer " <> token)
      conn = get(authenticated_connection, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      user = Authentication.get_user!(id)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      authenticated_connection =
        build_conn()
        |> put_req_header("authorization", "Bearer " <> token)
      conn = get(authenticated_connection, Routes.user_path(conn, :show, id))

      assert %{
        "id" => ^id,
        "email" => "some@email",
      } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "signup user" do
    test "renders valid token when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_up), user: @create_attrs)
      assert %{"jwt" => _} = json_response(conn, 201)["data"]
    end
  end

  describe "signin user" do
    setup [:create_user]

    test "renders valid token when data is valid", %{conn: conn, user: user} do
      conn = post(conn, Routes.user_path(conn, :sign_in), email: user.email, password: user.password)
      assert %{"jwt" => _} = json_response(conn, 200)["data"]
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid with proper authentication", %{conn: conn, user: %User{id: id} = user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      authenticated_connection =
        build_conn()
        |> put_req_header("authorization", "Bearer " <> token)

      conn = put(authenticated_connection, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
        "id" => ^id,
        "email" => "some updated@email",
      } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      authenticated_connection =
        build_conn()
        |> put_req_header("authorization", "Bearer " <> token)

      conn = put(authenticated_connection, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      authenticated_connection =
        build_conn()
        |> put_req_header("authorization", "Bearer " <> token)

      conn = delete(authenticated_connection, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
