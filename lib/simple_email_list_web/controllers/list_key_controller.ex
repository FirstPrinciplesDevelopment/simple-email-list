defmodule SimpleEmailListWeb.ListKeyController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.ListKey

  def index(conn, _params) do
    list_keys = Signups.list_list_keys()
    render(conn, "index.html", list_keys: list_keys)
  end

  def new(conn, _params) do
    changeset = Signups.change_list_key(%ListKey{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list_key" => list_key_params}) do
    case Signups.create_list_key(list_key_params) do
      {:ok, list_key} ->
        conn
        |> put_flash(:info, "List key created successfully.")
        |> redirect(to: Routes.list_key_path(conn, :show, list_key))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list_key = Signups.get_list_key!(id)
    render(conn, "show.html", list_key: list_key)
  end

  def edit(conn, %{"id" => id}) do
    list_key = Signups.get_list_key!(id)
    changeset = Signups.change_list_key(list_key)
    render(conn, "edit.html", list_key: list_key, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list_key" => list_key_params}) do
    list_key = Signups.get_list_key!(id)

    case Signups.update_list_key(list_key, list_key_params) do
      {:ok, list_key} ->
        conn
        |> put_flash(:info, "List key updated successfully.")
        |> redirect(to: Routes.list_key_path(conn, :show, list_key))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", list_key: list_key, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list_key = Signups.get_list_key!(id)
    {:ok, _list_key} = Signups.delete_list_key(list_key)

    conn
    |> put_flash(:info, "List key deleted successfully.")
    |> redirect(to: Routes.list_key_path(conn, :index))
  end
end
