defmodule SimpleEmailList.SignupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleEmailList.Signups` context.
  """

  @doc """
  Generate a unique signup email.
  """
  def unique_signup_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a signup.
  """
  def signup_fixture(attrs \\ %{}) do
    {:ok, signup} =
      attrs
      |> Enum.into(%{
        email: unique_signup_email(),
        name: "some name"
      })
      |> SimpleEmailList.Signups.create_signup()

    signup
  end
end
