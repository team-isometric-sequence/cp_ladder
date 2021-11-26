defmodule CpLadder.Repo do
  use Ecto.Repo,
    otp_app: :cp_ladder,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 100
end
