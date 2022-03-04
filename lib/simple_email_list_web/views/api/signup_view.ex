defmodule SimpleEmailListWeb.Api.SignupView do
  use SimpleEmailListWeb, :view
  alias SimpleEmailListWeb.Api.SignupView

  def render("show.json", %{signup: signup}) do
    %{data: render_one(signup, SignupView, "signup.json")}
  end

  def render("signup.json", %{signup: signup}) do
    %{
      email: signup.email,
      name: signup.name
    }
  end
end
