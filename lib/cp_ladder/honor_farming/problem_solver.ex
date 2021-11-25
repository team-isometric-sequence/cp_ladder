defmodule CpLadder.HonorFarming.ProblemSolver do
  use Ecto.Schema
  import Ecto.Changeset

  schema "problem_solvers" do
    field :problem_id, :id
    field :boj_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(problem_solver, attrs) do
    problem_solver
    |> cast(attrs, [:problem_id, :boj_user_id])
  end
end
