defmodule CpLadder.Repo.Migrations.CreateCategorizationRelatedRepos do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :tag_name, :string

      timestamps()
    end

    create table(:taggings) do
      add :problem_id, references(:problems, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)
      add :tag_name, :string

      timestamps()
    end

    create index(:tags, [:tag_name])
    create index(:taggings, [:problem_id, :tag_id])
  end
end
