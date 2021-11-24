defmodule CpLadder.AuthenticationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CpLadder.Authentication` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}@acme.com"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: attrs[:email] || unique_user_email(),
        password: attrs[:password] || "some password",
        password_confirmation: attrs[:password_confirmation] || "some password",
      })
      |> CpLadder.Authentication.create_user()

    user
  end
end
