defmodule SimpleEmailListWeb.ListKeyControllerTest do
  use SimpleEmailListWeb.ConnCase

  import SimpleEmailList.SignupsFixtures

  @create_attrs %{client_code: "7488a646-e31f-11e4-aace-600308960662"}
  @update_attrs %{client_code: "7488a646-e31f-11e4-aace-600308960668"}
  @invalid_attrs %{client_code: nil}

  describe "index" do
    test "lists all list_keys", %{conn: conn} do
      conn = get(conn, Routes.list_key_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing List keys"
    end
  end

  describe "new list_key" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.list_key_path(conn, :new))
      assert html_response(conn, 200) =~ "New List key"
    end
  end

  describe "create list_key" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.list_key_path(conn, :create), list_key: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.list_key_path(conn, :show, id)

      conn = get(conn, Routes.list_key_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show List key"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.list_key_path(conn, :create), list_key: @invalid_attrs)
      assert html_response(conn, 200) =~ "New List key"
    end
  end

  describe "edit list_key" do
    setup [:create_list_key]

    test "renders form for editing chosen list_key", %{conn: conn, list_key: list_key} do
      conn = get(conn, Routes.list_key_path(conn, :edit, list_key))
      assert html_response(conn, 200) =~ "Edit List key"
    end
  end

  describe "update list_key" do
    setup [:create_list_key]

    test "redirects when data is valid", %{conn: conn, list_key: list_key} do
      conn = put(conn, Routes.list_key_path(conn, :update, list_key), list_key: @update_attrs)
      assert redirected_to(conn) == Routes.list_key_path(conn, :show, list_key)

      conn = get(conn, Routes.list_key_path(conn, :show, list_key))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, list_key: list_key} do
      conn = put(conn, Routes.list_key_path(conn, :update, list_key), list_key: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit List key"
    end
  end

  describe "delete list_key" do
    setup [:create_list_key]

    test "deletes chosen list_key", %{conn: conn, list_key: list_key} do
      conn = delete(conn, Routes.list_key_path(conn, :delete, list_key))
      assert redirected_to(conn) == Routes.list_key_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.list_key_path(conn, :show, list_key))
      end
    end
  end

  defp create_list_key(_) do
    list_key = list_key_fixture()
    %{list_key: list_key}
  end
end
