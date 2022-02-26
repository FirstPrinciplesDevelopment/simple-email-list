defmodule SimpleEmailListWeb.Api.SignupController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.Signup

  alias SimpleEmailList.Accounts.User

  action_fallback SimpleEmailListWeb.FallbackController

  def create(conn, %{"signup" => signup_params}) do
    with {:ok, %Signup{} = signup} <- Signups.create_signup(signup_params, %User{}) do
      conn
      |> put_status(:created)
      |> render("show.json", signup: signup)
    end
  end
end
