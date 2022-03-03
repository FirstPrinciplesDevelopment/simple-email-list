defmodule SimpleEmailListWeb.ListKeyController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.ListKey

  def index(conn, %{"list_id" => list_id}) do
    list_keys = Signups.list_list_keys(conn.assigns[:current_user], list_id)
    render(conn, "index.html", list_keys: list_keys, list_id: list_id)
  end

  def new(conn, %{"list_id" => list_id}) do
    changeset = Signups.change_list_key(%ListKey{})
    render(conn, "new.html", changeset: changeset, list_id: list_id)
  end

  def create(conn, %{"list_id" => list_id}) do
    case Signups.create_list_key(list_id) do
      {:ok, list_key} ->
        conn
        |> put_flash(:info, "List key created successfully.")
        |> redirect(to: Routes.list_key_path(conn, :show, list_id, list_key))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, list_id: list_id)
    end
  end

  def show(conn, %{"list_id" => list_id, "id" => id}) do
    list_key = Signups.get_list_key!(list_id, id)
    render(conn, "show.html", list_key: list_key, list_id: list_id)
  end

  def delete(conn, %{"list_id" => list_id, "id" => id}) do
    list_key = Signups.get_list_key!(list_id, id)
    {:ok, _list_key} = Signups.delete_list_key(list_key)

    conn
    |> put_flash(:info, "List key deleted successfully.")
    |> redirect(to: Routes.list_key_path(conn, :index, list_id))
  end
end
