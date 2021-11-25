defmodule CpLadder.HonorFarmingTest do
  use CpLadder.DataCase

  alias CpLadder.HonorFarming

  describe "problems" do
    alias CpLadder.HonorFarming.Problem

    import CpLadder.HonorFarmingFixtures

    @invalid_attrs %{}

    test "list_problems/0 returns all problems" do
      problem = problem_fixture()
      assert HonorFarming.list_problems() == [problem]
    end

    test "get_problem!/1 returns the problem with given id" do
      problem = problem_fixture()
      assert HonorFarming.get_problem!(problem.id) == problem
    end

    test "create_problem/1 with valid data creates a problem" do
      valid_attrs = %{}

      assert {:ok, %Problem{} = problem} = HonorFarming.create_problem(valid_attrs)
    end

    test "create_problem/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HonorFarming.create_problem(@invalid_attrs)
    end

    test "update_problem/2 with valid data updates the problem" do
      problem = problem_fixture()
      update_attrs = %{}

      assert {:ok, %Problem{} = problem} = HonorFarming.update_problem(problem, update_attrs)
    end

    test "update_problem/2 with invalid data returns error changeset" do
      problem = problem_fixture()
      assert {:error, %Ecto.Changeset{}} = HonorFarming.update_problem(problem, @invalid_attrs)
      assert problem == HonorFarming.get_problem!(problem.id)
    end

    test "delete_problem/1 deletes the problem" do
      problem = problem_fixture()
      assert {:ok, %Problem{}} = HonorFarming.delete_problem(problem)
      assert_raise Ecto.NoResultsError, fn -> HonorFarming.get_problem!(problem.id) end
    end

    test "change_problem/1 returns a problem changeset" do
      problem = problem_fixture()
      assert %Ecto.Changeset{} = HonorFarming.change_problem(problem)
    end
  end
end
