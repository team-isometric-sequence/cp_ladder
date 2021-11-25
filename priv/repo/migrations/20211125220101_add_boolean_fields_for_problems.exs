defmodule CpLadder.Repo.Migrations.AddBooleanFieldsForProblems do
  use Ecto.Migration

  def change do
    alter table("problems") do
      add_if_not_exists :is_already_solved, :boolean, default: false
      add_if_not_exists :is_solvable, :boolean, default: false
    end
  end
end
