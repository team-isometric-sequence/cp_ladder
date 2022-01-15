defmodule CpLadder.Categorization do
  @moduledoc """
  The Categorization context.
  """

  import Ecto.Query, warn: false
  alias CpLadder.Repo

  alias CpLadder.Categorization.Tag
  alias CpLadder.Categorization.Tagging

  def add_to_problem(tag_name, problem) do
    tag = find_or_create_tag(tag_name)
    tagging = find_or_create_tagging(problem.id, tag.id)

    tagging
    |> update_tagging(%{tag_name: tag_name})
  end

  def find_or_create_tag(tag_name) do
    tag = get_tag_by_tag_name(tag_name)
    case tag do
      nil ->
        {:ok, result} = create_tag(%{tag_name: tag_name})
        result
      _ ->
        tag
    end
  end

  def get_tag_by_tag_name(tag_name), do: Repo.get_by(Tag, [tag_name: tag_name])

  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  def get_tagging(problem_id, tag_id) do
    Repo.get_by(Tagging, [tag_id: tag_id, problem_id: problem_id])
  end

  def create_tagging(attrs \\ %{}) do
    %Tagging{}
    |> Tagging.changeset(attrs)
    |> Repo.insert()
  end

  def find_or_create_tagging(problem_id, tag_id) do
    tagging = get_tagging(problem_id, tag_id)
    case tagging do
      nil ->
        {:ok, result} = create_tagging(%{tag_id: tag_id, problem_id: problem_id})
        result
      _ ->
        tagging
    end
  end

  def update_tagging(%Tagging{} = tagging, attrs) do
    tagging
    |> Tagging.changeset(attrs)
    |> Repo.update()
  end
end
