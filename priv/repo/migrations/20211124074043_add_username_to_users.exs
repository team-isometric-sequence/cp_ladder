defmodule CpLadder.Repo.Migrations.AddUsernameToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add_if_not_exists :username, :string
    end

    create unique_index(:users, [:username])
  end
end
