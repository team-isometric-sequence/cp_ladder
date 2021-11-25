defmodule CpLadder.HonorFarming.Problem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "problems" do
    field :title, :string
    field :problem_number, :integer
    field :tier, :integer

    field :solved_count, :integer
    field :submission_count, :integer

    field :is_solvable, :boolean
    field :is_already_solved, :boolean

    timestamps()
  end

  @doc false
  def changeset(problem, attrs) do
    updatable_fields = [
      :title,
      :problem_number,
      :tier,
      :solved_count,
      :submission_count,
      :is_solvable,
      :is_already_solved
    ]

    problem
    |> cast(attrs, updatable_fields)
  end
end
