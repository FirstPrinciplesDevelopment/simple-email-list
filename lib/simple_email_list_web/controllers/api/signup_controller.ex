defmodule SimpleEmailListWeb.Api.SignupController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.Signup
  alias SimpleEmailList.Signups.ListKey

  action_fallback SimpleEmailListWeb.FallbackController

  def create(conn, %{"client_code" => code, "signup" => signup_params}) do
    with %ListKey{} = list_key <- Signups.get_list_key(code),
         {:ok, %Signup{} = signup} <- Signups.create_signup(list_key.list_id, signup_params) do
      conn
      |> put_status(:created)
      |> render("show.json", signup: signup)
    end
  end
end
