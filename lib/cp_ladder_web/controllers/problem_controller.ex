defmodule CpLadderWeb.ProblemController do
  use CpLadderWeb, :controller

  alias CpLadder.HonorFarming

  action_fallback CpLadderWeb.FallbackController

  def index(conn, params) do
    page = HonorFarming.list_unsolved_problems(params)
    page_info = extract_page_info(page)

    render(conn, "index.json", problems: page.entries, page_info: page_info)
  end

  def show(conn, %{"boj_pk" => boj_pk}) do
    problem = HonorFarming.find_or_create_problem(boj_pk)
    render(conn, "show.json", problem: problem)
  end

  defp extract_page_info(page) do
    first_page = 1
    last_page = div(page.total_entries + page.page_size - 1, page.page_size)

    %{
      count: page.total_entries,
      currentPage: page.page_number,
      pageSize: page.page_size,
      hasPrevious: page.page_number != first_page,
      hasNext: page.page_number != last_page,
      startIndex: first_page,
      endIndex: last_page,
    }
  end
end
