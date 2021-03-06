defmodule SimpleEmailListWeb.Api.SignupController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.Signup
  alias SimpleEmailList.Signups.ListKey

  action_fallback SimpleEmailListWeb.FallbackController

  def options(conn, _params) do
    conn
    |> put_resp_header("Allow", "OPTIONS, POST")
    |> send_resp(204, "")
  end

  def create(conn, %{"client_code" => code, "signup" => signup_params}) do
    with {:ok, uuid} <- Ecto.UUID.cast(code),
         %ListKey{} = list_key <- Signups.get_list_key(uuid),
         {:ok, %Signup{} = signup} <- Signups.create_signup(list_key.list_id, signup_params) do
      conn
      |> put_status(:created)
      |> render("show.json", signup: signup)
    end
  end

  # Catchall clause, hanldes anything strange.
  def create(_conn, _params) do
    {:error, :invalid_payload}
  end
end
