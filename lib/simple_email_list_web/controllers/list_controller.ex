defmodule SimpleEmailListWeb.ListController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.List
  alias SimpleEmailList.Signups.ListKey

  plug :authorize_action when action in [:show, :edit, :update, :delete]

  def index(conn, _params) do
    lists = Signups.list_lists(conn.assigns[:current_user])
    render(conn, "index.html", lists: lists)
  end

  def new(conn, _params) do
    changeset = Signups.change_list(%List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list" => list_params}) do
    case Signups.create_list(conn.assigns[:current_user], list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List created successfully.")
        |> redirect(to: Routes.list_path(conn, :show, list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Signups.get_list!(id)
    list_keys = Signups.list_list_keys(id)
    signups = Signups.list_signups(id)
    changeset = Signups.change_list_key(%ListKey{})

    render(conn, "show.html",
      list: list,
      list_id: id,
      list_keys: list_keys,
      signups: signups,
      list_key_changeset: changeset
    )
  end

  def edit(conn, %{"id" => id}) do
    list = Signups.get_list!(id)
    changeset = Signups.change_list(list)
    render(conn, "edit.html", list: list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Signups.get_list!(id)

    case Signups.update_list(list, list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List updated successfully.")
        |> redirect(to: Routes.list_path(conn, :show, list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", list: list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Signups.get_list!(id)
    {:ok, _list} = Signups.delete_list(list)

    conn
    |> put_flash(:info, "List deleted successfully.")
    |> redirect(to: Routes.list_path(conn, :index))
  end

  defp authorize_action(conn, _params) do
    list = Signups.get_list!(conn.params["id"])

    if list.user_id != conn.assigns[:current_user].id do
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: Routes.list_path(conn, :index))
      |> halt()
    end

    conn
  end
end
