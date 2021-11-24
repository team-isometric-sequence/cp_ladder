defmodule CpLadder.Authentication do
  @moduledoc """
  The Authentication context.
  """

  import Ecto.Query, warn: false

  alias CpLadder.Repo
  alias CpLadder.Guardian
  alias CpLadder.Authentication.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

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
    |> User.changeset(attrs)
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
  Deletes a user.

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
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def request_external_authentication(username, password) do
    client_id = System.get_env("CP_LADDER_CLIENT_ID")
    client_secret = System.get_env("CP_LADDER_CLIENT_SECRET")
    site_url = "https://t-time-api.hongik.dev"

    credentials = "#{client_id}:#{client_secret}"

    # See https://github.com/jazzband/django-oauth-toolkit/blob/3a9541f903f8f945ff3f75a13b4953091717fffa/oauth2_provider/oauth2_validators.py#L85-L129
    response = HTTPoison.post!(
      site_url <> "/o/token/",
      {
        :form,
        [
          username: username,
          password: password,
          grant_type: "password",
          scope: "read"
        ]
      },
      %{
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Basic " <> Base.encode64(credentials)
      }
    )

    case response.status_code do
      200 ->
        {:ok, Poison.decode!(response.body)}
      _ ->
        {:error, "Authentication Failed"}
    end
  end

  def token_sign_in(username, password) do
    case try_login(username, password) do
      {:ok, user} ->
        IO.puts(Kernel.inspect(user))
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end

  defp try_login(username, password) when is_binary(username) and is_binary(password) do
    case request_external_authentication(username, password) do
      {:ok, payload} ->
        find_user_by_oauth_payload(payload)
      _ ->
        {:error, :unauthorized}
    end
  end

  defp find_user_by_oauth_payload(payload) do
    {:ok, member} = Map.fetch(payload, "member")
    {:ok, email} = Map.fetch(member, "email")

    case get_by_email(email) do
      {:ok, user} ->
        {:ok, user}
      _ ->
        create_oauth_user_locally(member)
    end
  end

  defp create_oauth_user_locally(payload) do
    password_candidate = Base.encode64(:crypto.strong_rand_bytes(20))

    %{
      "username" => username,
      "email" => email,
    } = payload

    user_attrs = %{
      "username" => username,
      "email" => email,
    }

    password_attrs = %{
      "password" => password_candidate,
      "password_confirmation" => password_candidate
    }

    attrs = Map.merge(user_attrs, password_attrs)
    create_user(attrs)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, "User Not Found."}
      user ->
        {:ok, user}
    end
  end
end
