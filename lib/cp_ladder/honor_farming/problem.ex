defmodule CpLadder.HonorFarming.Problem do
  use Ecto.Schema
  import Ecto.Changeset

  alias CpLadder.Categorization.Tagging

  schema "problems" do
    field :title, :string
    field :problem_number, :integer
    field :tier, :integer

    field :solved_count, :integer
    field :submission_count, :integer

    field :is_solvable, :boolean
    field :is_already_solved, :boolean

    field :is_solved_by_hongik, :boolean
    field :is_solved_by_ehwa, :boolean
    field :is_solved_by_sogang, :boolean
    field :is_solved_by_sookmyeong, :boolean
    field :is_solved_by_yonsei, :boolean

    has_many :taggings, Tagging

    timestamps()
  end

  @doc false
  def changeset(problem, attrs) do
    updatable_fields = [
      :title,
      :problem_number,
      :tier,
      :solved_count,
      :submission_count,
      :is_solvable,
      :is_already_solved,

      :is_solved_by_hongik,
      :is_solved_by_ehwa,
      :is_solved_by_sogang,
      :is_solved_by_sookmyeong,
      :is_solved_by_yonsei
    ]

    problem
    |> cast(attrs, updatable_fields)
  end
end
