defmodule SimpleEmailListWeb.Api.SignupControllerTest do
  use SimpleEmailListWeb.ConnCase

  import SimpleEmailList.SignupsFixtures

  alias SimpleEmailList.Signups.Signup

  @create_attrs %{
    email: "some email",
    name: "some name"
  }
  @invalid_attrs %{email: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create signup" do
    test "renders signup when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_signup_path(conn, :create), signup: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_signup_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some email",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_signup_path(conn, :create), signup: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_signup(_) do
    signup = signup_fixture()
    %{signup: signup}
  end
end
