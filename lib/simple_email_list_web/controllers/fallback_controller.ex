defmodule SimpleEmailListWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use SimpleEmailListWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SimpleEmailListWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause handles the case when the payload is missing required fields.
  def call(conn, {:error, :invalid_payload}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SimpleEmailListWeb.ChangesetView)
    |> render("error.json", %{error: "payload is invalid"})
  end

  # This clause handles the case when client_code is not even a UUID.
  def call(conn, :error) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SimpleEmailListWeb.ChangesetView)
    |> render("error.json", %{error: "client_code must be a valid UUID"})
  end

  # This clause handles the case when the client_code is not found.
  def call(conn, nil) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SimpleEmailListWeb.ChangesetView)
    |> render("error.json", %{error: "client_code does not exist"})
  end
end
