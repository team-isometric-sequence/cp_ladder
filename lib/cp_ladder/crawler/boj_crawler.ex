defmodule CpLadder.Crawler.BojCrawler do
  alias CpLadder.HonorFarming

  def crawl_problems() do
    Enum.each(
      1..300,
      fn page ->
        html = HTTPoison.get!("https://www.acmicpc.net/problemset/" <> Integer.to_string(page)).body
        problem_list = extract_problems_from_index_page(html)
        Process.sleep(200)
        Enum.each(
          problem_list,
          fn problem ->
            boj_pk = problem |> Integer.parse |> elem(0)
            HonorFarming.find_or_create_problem(boj_pk)
          end
        )
      end
    )
  end

  def crawl_school(school) do
    school_ranking_page_html = HTTPoison.get!("https://www.acmicpc.net/ranklist/school").body
    {:ok, href} = extract_school_url_from_ranking(school_ranking_page_html, school)

    1..20
    |> Enum.reduce_while(
        :ok,
        fn (page, acc) ->
          url = "https://www.acmicpc.net" <> href <> "/" <> Integer.to_string(page)
          response = HTTPoison.get!(url)

          case response.status_code do
            200 ->
              html = response.body
              users = extract_users_from_ranking(html)

              users
              |> Enum.each(
                  fn username ->
                    url = "https://www.acmicpc.net/user/" <> username
                    html = HTTPoison.get!(url).body

                    problems = extract_problems_from_user(html)

                    boj_user = HonorFarming.find_or_create_boj_user(username)

                    Process.sleep(200)
                    Enum.each(
                      problems,
                      fn problem_number ->
                        problem = HonorFarming.find_or_create_problem(problem_number)
                        HonorFarming.find_or_create_problem_solver(problem.id, boj_user.id)

                        problem
                        |> HonorFarming.update_problem(%{is_already_solved: true})
                      end
                    )
                  end
                )
              {:cont, acc}
            _ ->
              {:halt, acc}
          end
        end
      )
    href
  end

  defp extract_problems_from_index_page(html) do
    {:ok, index_parser} = Floki.parse_document(html)

    problem_rows =
      index_parser
      |> Floki.find("#problemset > tbody > tr")

    problem_list =
      for problem_row <- problem_rows,
      is_scorable_problem(problem_row),
      do: problem_row |> Floki.find("td:nth-of-type(1)") |> Floki.text

    problem_list
  end


  defp extract_problems_from_user(html) do
    {:ok, profile_parser} = Floki.parse_document(html)

    profile_panels =
      profile_parser
      |> Floki.find("div.col-md-9 > div.panel")

    problems_panel =
      profile_panels
      |> Enum.find(nil, fn panel -> String.contains?(Floki.text(panel), "문제") end)

    problem_tag_list =
      problems_panel
      |> Floki.find(".problem-list")
      |> Floki.find("a")

    problem_list = for tag <- problem_tag_list,
      do: Floki.text(tag) |> Integer.parse |> elem(0)
    problem_list
  end

  defp extract_users_from_ranking(html) do
    {:ok, ranking_parser} = Floki.parse_document(html)

    ranking_rows =
      ranking_parser
      |> Floki.find("#ranklist > tbody > tr > td:nth-of-type(2)")

    students_list = for ranker <- ranking_rows, do: ranker |> Floki.text |> String.trim
    students_list
  end


  defp extract_school_url_from_ranking(html, school_name) do
    {:ok, school_billboard_parser} = Floki.parse_document(html)

    billboard_rows =
      school_billboard_parser
      |> Floki.find("#ranklist > tbody > tr > td:nth-of-type(2)")

    matched_row =
      billboard_rows
      |> Enum.find(nil, fn row -> String.trim(Floki.text(row)) == school_name end)

    case matched_row do
      nil ->
        {:error, "Not found"}
      row ->
        href = Floki.attribute(row, "a", "href") |> List.first
        {:ok, href}
    end
  end

  defp is_scorable_problem(problem_row) do
    !String.contains?(Floki.text(problem_row), "채점 준비중")
  end
end
