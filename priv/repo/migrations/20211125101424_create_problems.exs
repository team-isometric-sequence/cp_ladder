defmodule CpLadder.Repo.Migrations.CreateProblems do
  use Ecto.Migration

  def change do
    create table(:problems) do
      add :title, :string, default: ""
      add :problem_number, :integer
      add :tier, :integer, default: 0

      add :solved_count, :integer, default: 0
      add :submission_count, :integer, default: 0

      timestamps()
    end

    create unique_index(:problems, [:problem_number])
  end
end
