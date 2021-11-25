defmodule Mix.Tasks.UpdateFromSolvedac do
  @moduledoc """

  updates problems from solved.ac

  `mix update_from_solvedac`
  """
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    Mix.Task.run "app.start"

    CpLadder.Crawler.SolvedacCrawler.crawl_solvedac_tiers()
  end
end
