defmodule SimpleEmailListWeb.SignupController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.Signup

  def index(conn, _params) do
    signups = Signups.list_signups()
    render(conn, "index.html", signups: signups)
  end

  def new(conn, _params) do
    changeset = Signups.change_signup(%Signup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"signup" => signup_params}) do
    case Signups.create_signup(signup_params) do
      {:ok, signup} ->
        conn
        |> put_flash(:info, "Signup created successfully.")
        |> redirect(to: Routes.signup_path(conn, :show, signup))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    signup = Signups.get_signup!(id)
    render(conn, "show.html", signup: signup)
  end

  def edit(conn, %{"id" => id}) do
    signup = Signups.get_signup!(id)
    changeset = Signups.change_signup(signup)
    render(conn, "edit.html", signup: signup, changeset: changeset)
  end

  def update(conn, %{"id" => id, "signup" => signup_params}) do
    signup = Signups.get_signup!(id)

    case Signups.update_signup(signup, signup_params) do
      {:ok, signup} ->
        conn
        |> put_flash(:info, "Signup updated successfully.")
        |> redirect(to: Routes.signup_path(conn, :show, signup))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", signup: signup, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    signup = Signups.get_signup!(id)
    {:ok, _signup} = Signups.delete_signup(signup)

    conn
    |> put_flash(:info, "Signup deleted successfully.")
    |> redirect(to: Routes.signup_path(conn, :index))
  end
end
