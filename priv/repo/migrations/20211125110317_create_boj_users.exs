defmodule CpLadder.Repo.Migrations.CreateBojUsers do
  use Ecto.Migration

  def change do
    create table(:boj_users) do
      add :boj_handle, :string

      timestamps()
    end

    create unique_index(:boj_users, [:boj_handle])
  end
end
