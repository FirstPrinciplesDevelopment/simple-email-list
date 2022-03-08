defmodule SimpleEmailListWeb.ListKeyController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.ListKey

  plug :authorize_action

  def create(conn, %{"list_id" => list_id}) do
    case Signups.create_list_key(list_id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Key created successfully.")
        |> redirect(to: Routes.list_path(conn, :show, list_id))

      {:error, _} ->
        conn
        |> put_flash(:danger, "Error creating key.")
        |> redirect(to: Routes.list_path(conn, :show, list_id))
    end
  end

  def delete(conn, %{"list_id" => list_id, "id" => id}) do
    list_key = Signups.get_list_key!(list_id, id)
    {:ok, _list_key} = Signups.delete_list_key(list_key)

    conn
    |> put_flash(:info, "Key deleted successfully.")
    |> redirect(to: Routes.list_path(conn, :show, list_id))
  end

  defp authorize_action(conn, _params) do
    list = Signups.get_list!(conn.params["list_id"])

    if list.user_id != conn.assigns[:current_user].id do
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: Routes.list_path(conn, :index))
      |> halt()
    end

    conn
  end
end
