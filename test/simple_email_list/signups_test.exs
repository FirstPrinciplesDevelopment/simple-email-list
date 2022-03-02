defmodule SimpleEmailList.SignupsTest do
  use SimpleEmailList.DataCase

  alias SimpleEmailList.Signups

  describe "lists" do
    alias SimpleEmailList.Signups.List

    import SimpleEmailList.SignupsFixtures

    @invalid_attrs %{name: nil}

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Signups.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Signups.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %List{} = list} = Signups.create_list(valid_attrs)
      assert list.name == "some name"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Signups.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %List{} = list} = Signups.update_list(list, update_attrs)
      assert list.name == "some updated name"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Signups.update_list(list, @invalid_attrs)
      assert list == Signups.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Signups.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Signups.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Signups.change_list(list)
    end
  end

  describe "list_keys" do
    alias SimpleEmailList.Signups.ListKey

    import SimpleEmailList.SignupsFixtures

    @invalid_attrs %{client_code: nil}

    test "list_list_keys/0 returns all list_keys" do
      list_key = list_key_fixture()
      assert Signups.list_list_keys() == [list_key]
    end

    test "get_list_key!/1 returns the list_key with given id" do
      list_key = list_key_fixture()
      assert Signups.get_list_key!(list_key.id) == list_key
    end

    test "create_list_key/1 with valid data creates a list_key" do
      valid_attrs = %{client_code: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %ListKey{} = list_key} = Signups.create_list_key(valid_attrs)
      assert list_key.client_code == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_list_key/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Signups.create_list_key(@invalid_attrs)
    end

    test "update_list_key/2 with valid data updates the list_key" do
      list_key = list_key_fixture()
      update_attrs = %{client_code: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %ListKey{} = list_key} = Signups.update_list_key(list_key, update_attrs)
      assert list_key.client_code == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_list_key/2 with invalid data returns error changeset" do
      list_key = list_key_fixture()
      assert {:error, %Ecto.Changeset{}} = Signups.update_list_key(list_key, @invalid_attrs)
      assert list_key == Signups.get_list_key!(list_key.id)
    end

    test "delete_list_key/1 deletes the list_key" do
      list_key = list_key_fixture()
      assert {:ok, %ListKey{}} = Signups.delete_list_key(list_key)
      assert_raise Ecto.NoResultsError, fn -> Signups.get_list_key!(list_key.id) end
    end

    test "change_list_key/1 returns a list_key changeset" do
      list_key = list_key_fixture()
      assert %Ecto.Changeset{} = Signups.change_list_key(list_key)
    end
  end
end
