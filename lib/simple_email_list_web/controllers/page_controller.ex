defmodule SimpleEmailListWeb.PageController do
  use SimpleEmailListWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
