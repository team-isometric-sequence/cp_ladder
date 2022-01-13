defmodule Mix.Tasks.UpdateFromBoj do
  @moduledoc """

  updates problem solvers from boj

  `mix update_from_boj`
  """
  use Mix.Task

  @impl Mix.Task
  def run(_) do
    Mix.Task.run "app.start"

    CpLadder.Crawler.BojCrawler.crawl_problems()
    if rem(Time.utc_now().hour, 2) == 0 do
      CpLadder.Crawler.BojCrawler.crawl_school("홍익대학교")
      CpLadder.Crawler.BojCrawler.crawl_school("서강대학교")
    else
      CpLadder.Crawler.BojCrawler.crawl_school("이화여자대학교")
      CpLadder.Crawler.BojCrawler.crawl_school("숙명여자대학교")
      CpLadder.Crawler.BojCrawler.crawl_school("연세대학교")
    end
  end
end
