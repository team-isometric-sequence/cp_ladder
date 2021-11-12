defmodule CpLadder.Authentication.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Bcrypt, only: [hash_pwd_salt: 1]

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :boj_handle, :string

    # Virtual fields:
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation, :boj_handle]) # Remove hash, add pw + pw confirmation
    |> validate_required([:email, :password, :password_confirmation]) # Remove hash, add pw + pw confirmation
    |> validate_format(:email, ~r/@/) # Check that email is valid
    |> validate_length(:password, min: 8) # Check that password length is >= 8
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> unique_constraint(:email)
    |> unique_constraint(:boj_handle)
    |> put_password_hash # Add put_password_hash to changeset pipeline
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hash_pwd_salt(pass))
      _ ->
          changeset
    end
  end

end
