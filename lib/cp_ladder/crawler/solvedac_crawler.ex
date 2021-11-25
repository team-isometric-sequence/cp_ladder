defmodule CpLadder.Crawler.SolvedacCrawler do
  alias CpLadder.HonorFarming
  alias CpLadder.HonorFarming.Problem

  def crawl_solvedac_tiers do
    problems = HonorFarming.list_problems()
    page_size = 100
    total_pages = div(length(problems), page_size) + 1

    1..total_pages
    |> Enum.each(
        fn current_page ->
          pagination =
            Problem
            |> CpLadder.Repo.paginate(page: current_page, page_size: page_size)

          query_string =
            pagination.entries
            |> Enum.map(fn problem -> problem.problem_number end)
            |> Enum.join(",")

          update_solvedac_metrics(query_string)
        end
      )
  end

  def update_solvedac_metrics(query_string) do
    url = "https://solved.ac/api/v3/problem/lookup?problemIds=" <> query_string
    Process.sleep(200)

    response = HTTPoison.get!(url)
    case response.status_code do
      200 ->
        jsonArray =
          response.body
          |> Poison.decode!

        jsonArray
        |> Enum.each(
            fn json ->
              %{
                "problemId" => boj_pk,
                "titleKo" => title,
                "level" => tier,
                "acceptedUserCount" => solved_count,
                "averageTries" => submission_rate,
              } = json

              problem = HonorFarming.find_or_create_problem(boj_pk)
              problem
              |> HonorFarming.update_problem(%{
                  title: title,
                  tier: tier,
                  solved_count: solved_count,
                  submission_rcount: solved_count * (submission_rate || 0)
                })
            end
          )
      _ ->
        nil
    end
  end
end
