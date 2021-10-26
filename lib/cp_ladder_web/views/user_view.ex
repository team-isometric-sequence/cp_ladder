defmodule CpLadderWeb.UserView do
  use CpLadderWeb, :view
  alias CpLadderWeb.UserView

  def render("index.json", %{users: users}) do
    render_with_result(render_many(users, UserView, "user.json"))
  end

  def render("show.json", %{user: user}) do
    render_with_result(render_one(user, UserView, "user.json"))
  end

  def render("jwt.json", %{jwt: jwt}) do
    render_with_result(%{jwt: jwt})
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      password_hash: user.password_hash,
      boj_handle: user.boj_handle,
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      password_hash: user.password_hash,
      boj_handle: user.boj_handle,
    }
  end

  def render("errors.json", json) do
    render_with_failure(json)
  end

  defp render_with_result(json) do
    %{
      ok: true,
      data: json,
      errors: nil
    }
  end

  defp render_with_failure(json) do
    %{
      ok: false,
      data: nil,
      errors: [%{user: json}]
    }
  end
end
