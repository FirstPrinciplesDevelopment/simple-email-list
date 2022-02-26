defmodule SimpleEmailList.Repo do
  use Ecto.Repo,
    otp_app: :simple_email_list,
    adapter: Ecto.Adapters.Postgres
end
