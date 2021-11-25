defmodule Mix.Tasks.UpdateFromSolvedac do
  @moduledoc """

  updates problems from solved.ac

  `mix update_from_solvedac`
  """
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    [:hackney, :postgrex, :ecto]
    |> Enum.each(&Application.ensure_all_started/1)

    CpLadder.Repo.start_link()

    CpLadder.Crawler.SolvedacCrawler.crawl_solvedac_tiers()
  end
end
