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

  @doc """
  Generate a list_key.
  """
  def list_key_fixture(attrs \\ %{}) do
    {:ok, list_key} =
      attrs
      |> Enum.into(%{
        client_code: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> SimpleEmailList.Signups.create_list_key()

    list_key
  end
end
