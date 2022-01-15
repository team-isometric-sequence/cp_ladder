defmodule CpLadder.Categorization.Tagging do
  use Ecto.Schema
  import Ecto.Changeset

  schema "taggings" do
    field :problem_id, :id
    field :tag_id, :id
    field :tag_name, :string

    timestamps()
  end

  @doc false
  def changeset(tagging, attrs) do
    tagging
    |> cast(attrs, [:problem_id, :tag_id, :tag_name])
  end
end
