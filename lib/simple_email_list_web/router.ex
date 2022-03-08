defmodule SimpleEmailListWeb.Router do
  use SimpleEmailListWeb, :router

  import SimpleEmailListWeb.UserAuth
  alias SimpleEmailListWeb.Api.SignupController, as: ApiController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SimpleEmailListWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1" do
    pipe_through :api

    post "/signups/create", ApiController, :create
  end

  scope "/", SimpleEmailListWeb do
    pipe_through [:browser, :require_authenticated_user]

    resources "/", ListController

    post "/:list_id/keys", ListKeyController, :create
    delete "/:list_id/keys/:id", ListKeyController, :delete

    get "/:list_id/signups/:id/edit", SignupController, :edit
    get "/:list_id/signups/new", SignupController, :new
    post "/:list_id/signups", SignupController, :create
    patch "/:list_id/signups/:id", SignupController, :update
    put "/:list_id/signups/:id", SignupController, :update
    delete "/:list_id/signups/:id", SignupController, :delete
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", SimpleEmailListWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", SimpleEmailListWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", SimpleEmailListWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
