defmodule CpLadder.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :boj_handle, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:boj_handle])
  end
end
