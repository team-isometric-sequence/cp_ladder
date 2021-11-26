defmodule CpLadderWeb.ProblemView do
  use CpLadderWeb, :view
  alias CpLadderWeb.ProblemView

  def render("index.json", %{problems: problems, page_info: page_info}) do
    render_with_result(%{
      objects: render_many(problems, ProblemView, "problem.json"),
      pageInfo: page_info
    })
  end

  def render("show.json", %{problem: problem}) do
    render_with_result(render_one(problem, ProblemView, "problem.json"))
  end

  def render("problem.json", %{problem: problem}) do
    %{
      problemNumber: problem.problem_number,
      title: problem.title,
      tier: problem.tier,
      solvedCount: problem.solved_count,
      submissionCount: problem.submission_count
    }
  end

  def render("errors.json", json) do
    render_with_failure(json)
  end

  defp render_with_result(json) do
    %{
      ok: true,
      data: json,
      errors: nil
    }
  end

  defp render_with_failure(json) do
    %{
      ok: false,
      data: nil,
      errors: [%{problem: json}]
    }
  end
end
