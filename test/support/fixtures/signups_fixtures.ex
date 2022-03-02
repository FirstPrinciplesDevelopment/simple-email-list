defmodule SimpleEmailList.SignupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleEmailList.Signups` context.
  """

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> SimpleEmailList.Signups.create_list()

    list
  end
end
