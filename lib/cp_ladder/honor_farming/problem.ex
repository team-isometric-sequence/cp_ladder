defmodule CpLadder.HonorFarming.Problem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "problems" do
    field :title, :string
    field :problem_number, :integer
    field :tier, :integer

    field :solved_count, :integer
    field :submission_count, :integer

    timestamps()
  end

  @doc false
  def changeset(problem, attrs) do
    problem
    |> cast(attrs, [:title, :problem_number, :tier, :solved_count, :submission_count])
  end
end
