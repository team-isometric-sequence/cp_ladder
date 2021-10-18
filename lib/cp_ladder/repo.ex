defmodule CpLadder.Repo do
  use Ecto.Repo,
    otp_app: :cp_ladder,
    adapter: Ecto.Adapters.Postgres
end
