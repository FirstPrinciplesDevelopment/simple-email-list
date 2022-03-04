defmodule SimpleEmailListWeb.SignupController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.Signup

  plug :authorize_action

  def index(conn, %{"list_id" => list_id}) do
    signups = Signups.list_signups(list_id)
    render(conn, "index.html", signups: signups, list_id: list_id)
  end

  def new(conn, %{"list_id" => list_id}) do
    changeset = Signups.change_signup(%Signup{})
    render(conn, "new.html", changeset: changeset, list_id: list_id)
  end

  def create(conn, %{"list_id" => list_id, "signup" => signup_params}) do
    case Signups.create_signup(list_id, signup_params) do
      {:ok, signup} ->
        conn
        |> put_flash(:info, "Signup created successfully.")
        |> redirect(to: Routes.signup_path(conn, :show, list_id, signup))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, list_id: list_id)
    end
  end

  def show(conn, %{"list_id" => list_id, "id" => id}) do
    signup = Signups.get_signup!(list_id, id)
    render(conn, "show.html", signup: signup, list_id: list_id)
  end

  def edit(conn, %{"list_id" => list_id, "id" => id}) do
    signup = Signups.get_signup!(list_id, id)
    changeset = Signups.change_signup(signup)
    render(conn, "edit.html", signup: signup, changeset: changeset, list_id: list_id)
  end

  def update(conn, %{"list_id" => list_id, "id" => id, "signup" => signup_params}) do
    signup = Signups.get_signup!(list_id, id)

    case Signups.update_signup(signup, signup_params) do
      {:ok, signup} ->
        conn
        |> put_flash(:info, "Signup updated successfully.")
        |> redirect(to: Routes.signup_path(conn, :show, list_id, signup))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", signup: signup, changeset: changeset, list_id: list_id)
    end
  end

  def delete(conn, %{"list_id" => list_id, "id" => id}) do
    signup = Signups.get_signup!(list_id, id)
    {:ok, _signup} = Signups.delete_signup(signup)

    conn
    |> put_flash(:info, "Signup deleted successfully.")
    |> redirect(to: Routes.signup_path(conn, :index, list_id))
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
