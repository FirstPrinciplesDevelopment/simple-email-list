defmodule SimpleEmailList.Signups do
  @moduledoc """
  The Signups context.
  """

  import Ecto.Query, warn: false
  alias SimpleEmailList.Repo

  alias SimpleEmailList.Signups.Signup

  alias SimpleEmailList.Accounts.User

  @doc """
  Returns the list of signups for the current user.

  ## Examples

      iex> list_signups(%User{})
      [%Signup{}, ...]

  """
  def list_signups(%User{} = current_user) do
    Repo.all(from s in Signup, where: s.user_id == ^current_user.id)
  end

  @doc """
  Gets a single signup by id and current user.

  Raises `Ecto.NoResultsError` if the Signup does not exist.

  ## Examples

      iex> get_signup!(123, %User{})
      %Signup{}

      iex> get_signup!(456, %User{})
      ** (Ecto.NoResultsError)

  """
  def get_signup!(id, %User{} = current_user) do
    Repo.get_by!(Signup, id: id, user_id: current_user.id)
  end

  @doc """
  Creates a signup.

  ## Examples

      iex> create_signup(%{field: value}, %User{})
      {:ok, %Signup{}}

      iex> create_signup(%{field: bad_value}, %User{})
      {:error, %Ecto.Changeset{}}

  """
  def create_signup(attrs \\ %{}, %User{} = current_user) do
    current_user
    |> Ecto.build_assoc(:signups)
    |> Signup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a signup.

  ## Examples

      iex> update_signup(signup, %{field: new_value}, %User{})
      {:ok, %Signup{}}

      iex> update_signup(signup, %{field: bad_value}, %User{})
      {:error, %Ecto.Changeset{}}

  """
  def update_signup(%Signup{} = signup, attrs, %User{} = current_user) do
    if signup.user_id == current_user.id do
      signup
      |> Signup.changeset(attrs)
      |> Repo.update()
    end
  end

  @doc """
  Deletes a signup.

  ## Examples

      iex> delete_signup(signup, %User{})
      {:ok, %Signup{}}

      iex> delete_signup(signup, %User{})
      {:error, %Ecto.Changeset{}}

  """
  def delete_signup(%Signup{} = signup, %User{} = current_user) do
    if signup.user_id == current_user.id do
      Repo.delete(signup)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking signup changes.

  ## Examples

      iex> change_signup(signup)
      %Ecto.Changeset{data: %Signup{}}

  """
  def change_signup(%Signup{} = signup, attrs \\ %{}) do
    Signup.changeset(signup, attrs)
  end
end
