defmodule SimpleEmailList.Signups do
  @moduledoc """
  The Signups context.
  """

  import Ecto.Query, warn: false
  alias SimpleEmailList.Repo

  alias SimpleEmailList.Signups.List

  @doc """
  Returns the list of lists.

  ## Examples

      iex> list_lists()
      [%List{}, ...]

  """
  def list_lists do
    Repo.all(List)
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
  Creates a list.

  ## Examples

      iex> create_list(%{field: value})
      {:ok, %List{}}

      iex> create_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list(attrs \\ %{}) do
    %List{}
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
  Returns the list of list_keys.

  ## Examples

      iex> list_list_keys()
      [%ListKey{}, ...]

  """
  def list_list_keys do
    Repo.all(ListKey)
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
  def get_list_key!(id), do: Repo.get!(ListKey, id)

  @doc """
  Creates a list_key.

  ## Examples

      iex> create_list_key(%{field: value})
      {:ok, %ListKey{}}

      iex> create_list_key(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list_key(attrs \\ %{}) do
    %ListKey{}
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
end
