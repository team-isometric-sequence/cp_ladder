defmodule CpLadder.Repo.Migrations.CreateIndexOnSolvedSchool do
  use Ecto.Migration
  import Ecto.Query

  def change do
    alter table("problems") do
      add_if_not_exists :is_solved_by_hongik, :boolean, default: false
      add_if_not_exists :is_solved_by_ehwa, :boolean, default: false
      add_if_not_exists :is_solved_by_sogang, :boolean, default: false
      add_if_not_exists :is_solved_by_sookmyeong, :boolean, default: false
      add_if_not_exists :is_solved_by_yonsei, :boolean, default: false
    end

    create index(:problems, [:is_solved_by_hongik])
    create index(:problems, [:is_solved_by_ehwa])
    create index(:problems, [:is_solved_by_sogang])
    create index(:problems, [:is_solved_by_sookmyeong])
    create index(:problems, [:is_solved_by_yonsei])

    # See https://elixirforum.com/t/ecto-migration-with-data-entry/1722/3
    flush()

    from(p in CpLadder.HonorFarming.Problem, update: [set: [is_solved_by_hongik: p.is_already_solved]])
    |> CpLadder.Repo.update_all([])
  end
end
