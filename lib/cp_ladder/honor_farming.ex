defmodule CpLadder.HonorFarming do
  @moduledoc """
  The HonorFarming context.
  """

  import Ecto.Query, warn: false
  alias CpLadder.Repo

  alias CpLadder.HonorFarming.Problem
  alias CpLadder.HonorFarming.BojUser
  alias CpLadder.HonorFarming.ProblemSolver

  alias CpLadder.Categorization
  alias CpLadder.Categorization.Tagging
  @doc """
  Returns the list of problems.

  ## Examples

      iex> list_problems()
      [%Problem{}, ...]

  """
  def list_problems do
    Repo.all(Problem)
  end

  @spec list_unsolved_problems(keyword | map) :: Scrivener.Page.t(Problem)
  def list_unsolved_problems(params) do
    allow_unranked = params |> Map.get("allow_unranked", 0)
    school = params |> Map.get("school", "hongik")
    tag_name = params |> Map.get("tag", "")

    query = filter_by_school(school)
    query = filter_by_tag(query, tag_name)

    query = if allow_unranked == 1 do
      query
    else
      query
      |> where([p], p.tier > 0)
    end

    page =
      query
      |> order_by(^generate_filter_option(params))
      |> preload(:taggings)
      |> Repo.paginate(params)

    page
  end

  defp filter_by_tag(query, tag_name) do
    case tag_name do
      "" -> query
      _ ->
        tag = Categorization.find_or_create_tag(tag_name)

        taggings =
          Tagging
          |> where([t], t.tag_id == ^tag.id)

        from(p in query, join: s in subquery(taggings), on: s.id == p.id)
    end
  end

  defp filter_by_school(school) do
    case school do
      "ehwa" -> Problem |> where([p], p.is_solvable == true and p.is_solved_by_ehwa == false)
      "sogang" -> Problem |> where([p], p.is_solvable == true and p.is_solved_by_sogang == false)
      "sookmyeong" -> Problem |> where([p], p.is_solvable == true and p.is_solved_by_sookmyeong == false)
      "yonsei" -> Problem |> where([p], p.is_solvable == true and p.is_solved_by_yonsei == false)
      _ -> Problem |> where([p], p.is_solvable == true and p.is_solved_by_hongik == false)
    end
  end

  defp generate_filter_option(params) do
    order_by = params |> Map.get("order_by")

    case order_by do
      "tier_asc" -> [asc: :tier]
      "solved_count_asc" -> [asc: :solved_count]
      "submission_count_asc" -> [asc: :submission_count]
      "tier_desc" -> [desc: :tier]
      "solved_count_desc" -> [desc: :solved_count]
      "submission_count_desc" -> [desc: :submission_count]
      _ -> [asc: :tier]
    end
  end

  @doc """
  Gets a single problem.

  Raises `Ecto.NoResultsError` if the Problem does not exist.

  ## Examples

      iex> get_problem!(123)
      %Problem{}

      iex> get_problem!(456)
      ** (Ecto.NoResultsError)

  """
  def get_problem!(id), do: Repo.get!(Problem, id)

    @doc """
  Gets a single problem.

  Raises `Ecto.NoResultsError` if the Problem does not exist.

  ## Examples

      iex> get_problem!(123)
      %Problem{}

      iex> get_problem!(456)
      ** (Ecto.NoResultsError)

  """
  def get_problem_by_boj_pk(boj_pk), do: Repo.get_by(Problem, [problem_number: boj_pk])

  def get_boj_user_by_handle(boj_handle), do: Repo.get_by(BojUser, [boj_handle: boj_handle])

  def get_problem_solver(problem_id, boj_user_id) do
    Repo.get_by(ProblemSolver, [boj_user_id: boj_user_id, problem_id: problem_id])
  end

  @doc """
  Creates a problem.

  ## Examples

      iex> create_problem(%{field: value})
      {:ok, %Problem{}}

      iex> create_problem(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_problem(attrs \\ %{}) do
    %Problem{}
    |> Problem.changeset(attrs)
    |> Repo.insert()
  end

  def create_boj_user(attrs \\ %{}) do
    %BojUser{}
    |> BojUser.changeset(attrs)
    |> Repo.insert()
  end

  def create_problem_solver(attrs \\ %{}) do
    %ProblemSolver{}
    |> ProblemSolver.changeset(attrs)
    |> Repo.insert()
  end

  def find_or_create_problem(boj_pk) do
    problem = get_problem_by_boj_pk(boj_pk)
    case problem do
      nil ->
        {:ok, result} = create_problem(%{problem_number: boj_pk})
        result
      _ ->
        problem
    end
  end

  def find_or_create_boj_user(boj_handle) do
    boj_user = get_boj_user_by_handle(boj_handle)
    case boj_user do
      nil ->
        {:ok, result} = create_boj_user(%{boj_handle: boj_handle})
        result
      _ ->
        boj_user
    end
  end

  def find_or_create_problem_solver(problem_id, boj_user_id) do
    problem_solver = get_problem_solver(problem_id, boj_user_id)
    case problem_solver do
      nil ->
        {:ok, result} = create_problem_solver(%{boj_user_id: boj_user_id, problem_id: problem_id})
        result
      _ ->
        problem_solver
    end
  end

  @doc """
  Updates a problem.

  ## Examples

      iex> update_problem(problem, %{field: new_value})
      {:ok, %Problem{}}

      iex> update_problem(problem, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_problem(%Problem{} = problem, attrs) do
    problem
    |> Problem.changeset(attrs)
    |> Repo.update()
  end
end
