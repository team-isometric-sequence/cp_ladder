defmodule CpLadder.HonorFarming.BojUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boj_users" do
    field :boj_handle, :string

    timestamps()
  end

  @doc false
  def changeset(boj_user, attrs) do
    boj_user
    |> cast(attrs, [:boj_handle])
    |> validate_required([:boj_handle])
  end
end
