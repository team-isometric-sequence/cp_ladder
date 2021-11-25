defmodule CpLadder.Repo.Migrations.CreateProblemSolvers do
  use Ecto.Migration

  def change do
    create table(:problem_solvers) do
      add :problem_id, references(:problems, on_delete: :nothing)
      add :boj_user_id, references(:boj_users, on_delete: :nothing)

      timestamps()
    end

    create index(:problem_solvers, [:problem_id])
    create index(:problem_solvers, [:boj_user_id])
  end
end
