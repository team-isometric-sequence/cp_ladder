defmodule CpLadder.Categorization.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :tag_name, :string

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:tag_name])
    |> validate_required([:tag_name])
  end
end
