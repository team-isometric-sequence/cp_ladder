defmodule CpLadder.HonorFarmingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CpLadder.HonorFarming` context.
  """

  @doc """
  Generate a problem.
  """
  def problem_fixture(attrs \\ %{}) do
    {:ok, problem} =
      attrs
      |> Enum.into(%{

      })
      |> CpLadder.HonorFarming.create_problem()

    problem
  end
end
