defmodule CpLadder.HonorFarming do
  @moduledoc """
  The HonorFarming context.
  """

  import Ecto.Query, warn: false
  alias CpLadder.Repo

  alias CpLadder.HonorFarming.Problem
  alias CpLadder.HonorFarming.BojUser
  alias CpLadder.HonorFarming.ProblemSolver

  @doc """
  Returns the list of problems.

  ## Examples

      iex> list_problems()
      [%Problem{}, ...]

  """
  def list_problems do
    Repo.all(Problem)
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
