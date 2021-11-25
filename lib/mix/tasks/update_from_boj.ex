defmodule Mix.Tasks.UpdateFromBoj do
  @moduledoc """

  updates problem solvers from boj

  `mix update_from_boj`
  """
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    [:hackney, :postgrex, :ecto]
    |> Enum.each(&Application.ensure_all_started/1)

    CpLadder.Repo.start_link()

    CpLadder.Crawler.BojCrawler.crawl_problems()
    CpLadder.Crawler.BojCrawler.crawl_school("홍익대학교")
  end
end
