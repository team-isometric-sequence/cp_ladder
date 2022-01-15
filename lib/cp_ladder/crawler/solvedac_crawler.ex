defmodule CpLadder.Crawler.SolvedacCrawler do
  import Ecto.Query
  alias CpLadder.HonorFarming
  alias CpLadder.HonorFarming.Problem

  alias CpLadder.Categorization

  def crawl_solvedac_tiers do
    problems = HonorFarming.list_problems()
    page_size = 100
    total_pages = div(length(problems), page_size) + 1

    1..total_pages
    |> Enum.each(
        fn current_page ->
          pagination =
            Problem
            |> order_by(asc: :tier)
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

    response = HTTPoison.get!(url, [], [timeout: 500_000, recv_timeout: 500_000])
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
                "isSolvable" => is_solvable,
                "tags" => tags
              } = json

              problem = HonorFarming.find_or_create_problem(boj_pk)
              problem
              |> HonorFarming.update_problem(%{
                  title: title,
                  tier: tier,
                  solved_count: solved_count,
                  submission_count: round(solved_count * submission_rate),
                  is_solvable: is_solvable
                })

              tags
              |> Enum.each(fn tag -> update_tagging(problem, tag) end)
            end
          )
      _ ->
        nil
    end
  end

  defp update_tagging(problem, tag) do
    %{
      "key" => tag_name
    } = tag

    Categorization.add_to_problem(tag_name, problem)
  end
end
