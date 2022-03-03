defmodule SimpleEmailList.Signups do
  @moduledoc """
  The Signups context.
  """

  import Ecto.Query, warn: false
  alias SimpleEmailList.Repo

  alias SimpleEmailList.Accounts.User
  alias SimpleEmailList.Signups.List

  @doc """
  Returns the list of lists for a user.

  ## Examples

      iex> list_lists(%User{})
      [%List{}, ...]

  """
  def list_lists(%User{} = user) do
    Repo.all(from l in List, where: l.user_id == ^user.id)
  end

  @doc """
  Gets a single list.

  Raises `Ecto.NoResultsError` if the List does not exist.

  ## Examples

      iex> get_list!(123)
      %List{}

      iex> get_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_list!(id), do: Repo.get!(List, id)

  @doc """
  Creates a list, that has a relation to a user.

  ## Examples

      iex> create_list(%User{}, %{field: value})
      {:ok, %List{}}

      iex> create_list(%User{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list(%User{} = user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:lists)
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a list.

  ## Examples

      iex> update_list(list, %{field: new_value})
      {:ok, %List{}}

      iex> update_list(list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_list(%List{} = list, attrs) do
    list
    |> List.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a list.

  ## Examples

      iex> delete_list(list)
      {:ok, %List{}}

      iex> delete_list(list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_list(%List{} = list) do
    Repo.delete(list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking list changes.

  ## Examples

      iex> change_list(list)
      %Ecto.Changeset{data: %List{}}

  """
  def change_list(%List{} = list, attrs \\ %{}) do
    List.changeset(list, attrs)
  end

  alias SimpleEmailList.Signups.ListKey

  @doc """
  Returns the list of keys for one of a user's lists.

  ## Examples

      iex> list_list_keys(%User{}, list_id)
      [%ListKey{}, ...]

  """
  def list_list_keys(%User{} = user, list_id) do
    Repo.all(
      from k in ListKey,
        join: l in assoc(k, :list),
        where: l.id == ^list_id,
        where: l.user_id == ^user.id,
        preload: [list: l]
    )
  end

  @doc """
  Gets a single list_key.

  Raises `Ecto.NoResultsError` if the List key does not exist.

  ## Examples

      iex> get_list_key!(123)
      %ListKey{}

      iex> get_list_key!(456)
      ** (Ecto.NoResultsError)

  """
  def get_list_key!(list_id, id) do
    Repo.get_by!(ListKey, list_id: list_id, id: id)
  end

  @doc """
  Creates a list_key.

  ## Examples

      iex> create_list_key(%{field: value})
      {:ok, %ListKey{}}

      iex> create_list_key(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list_key(list_id, attrs \\ %{}) do
    %ListKey{list_id: list_id, client_code: Ecto.UUID.generate()}
    |> ListKey.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a list_key.

  ## Examples

      iex> update_list_key(list_key, %{field: new_value})
      {:ok, %ListKey{}}

      iex> update_list_key(list_key, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_list_key(%ListKey{} = list_key, attrs) do
    list_key
    |> ListKey.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a list_key.

  ## Examples

      iex> delete_list_key(list_key)
      {:ok, %ListKey{}}

      iex> delete_list_key(list_key)
      {:error, %Ecto.Changeset{}}

  """
  def delete_list_key(%ListKey{} = list_key) do
    Repo.delete(list_key)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking list_key changes.

  ## Examples

      iex> change_list_key(list_key)
      %Ecto.Changeset{data: %ListKey{}}

  """
  def change_list_key(%ListKey{} = list_key, attrs \\ %{}) do
    ListKey.changeset(list_key, attrs)
  end

  alias SimpleEmailList.Signups.Signup

  @doc """
  Returns the list of signups for a user's list.

  ## Examples

      iex> list_signups(%User{}, list_id)
      [%Signup{}, ...]

  """
  def list_signups(%User{} = user, list_id) do
    Repo.all(
      from s in Signup,
        join: l in assoc(s, :list),
        where: l.id == ^list_id,
        where: l.user_id == ^user.id,
        preload: [list: l]
    )
  end

  @doc """
  Gets a single signup by list_id and id.

  Raises `Ecto.NoResultsError` if the Signup does not exist.

  ## Examples

      iex> get_signup!(list_id, signup_id)
      %Signup{}

      iex> get_signup!(list_id, signup_id)
      ** (Ecto.NoResultsError)

  """
  def get_signup!(list_id, id) do
    Repo.get_by!(Signup, list_id: list_id, id: id)
  end

  @doc """
  Creates a signup.

  ## Examples

      iex> create_signup(%{field: value})
      {:ok, %Signup{}}

      iex> create_signup(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_signup(list_id, attrs \\ %{}) do
    %Signup{list_id: list_id}
    |> Signup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a signup.

  ## Examples

      iex> update_signup(signup, %{field: new_value})
      {:ok, %Signup{}}

      iex> update_signup(signup, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_signup(%Signup{} = signup, attrs) do
    signup
    |> Signup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a signup.

  ## Examples

      iex> delete_signup(signup)
      {:ok, %Signup{}}

      iex> delete_signup(signup)
      {:error, %Ecto.Changeset{}}

  """
  def delete_signup(%Signup{} = signup) do
    Repo.delete(signup)
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
