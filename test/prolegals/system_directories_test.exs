defmodule Prolegals.SystemDirectoriesTest do
  use Prolegals.DataCase

  alias Prolegals.SystemDirectories

  describe "tbl_system_directories" do
    alias Prolegals.SystemDirectories.Directory

    @valid_attrs %{failed: "some failed", processed: "some processed"}
    @update_attrs %{failed: "some updated failed", processed: "some updated processed"}
    @invalid_attrs %{failed: nil, processed: nil}

    def directory_fixture(attrs \\ %{}) do
      {:ok, directory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SystemDirectories.create_directory()

      directory
    end

    test "list_tbl_system_directories/0 returns all tbl_system_directories" do
      directory = directory_fixture()
      assert SystemDirectories.list_tbl_system_directories() == [directory]
    end

    test "get_directory!/1 returns the directory with given id" do
      directory = directory_fixture()
      assert SystemDirectories.get_directory!(directory.id) == directory
    end

    test "create_directory/1 with valid data creates a directory" do
      assert {:ok, %Directory{} = directory} = SystemDirectories.create_directory(@valid_attrs)
      assert directory.failed == "some failed"
      assert directory.processed == "some processed"
    end

    test "create_directory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SystemDirectories.create_directory(@invalid_attrs)
    end

    test "update_directory/2 with valid data updates the directory" do
      directory = directory_fixture()
      assert {:ok, %Directory{} = directory} = SystemDirectories.update_directory(directory, @update_attrs)
      assert directory.failed == "some updated failed"
      assert directory.processed == "some updated processed"
    end

    test "update_directory/2 with invalid data returns error changeset" do
      directory = directory_fixture()
      assert {:error, %Ecto.Changeset{}} = SystemDirectories.update_directory(directory, @invalid_attrs)
      assert directory == SystemDirectories.get_directory!(directory.id)
    end

    test "delete_directory/1 deletes the directory" do
      directory = directory_fixture()
      assert {:ok, %Directory{}} = SystemDirectories.delete_directory(directory)
      assert_raise Ecto.NoResultsError, fn -> SystemDirectories.get_directory!(directory.id) end
    end

    test "change_directory/1 returns a directory changeset" do
      directory = directory_fixture()
      assert %Ecto.Changeset{} = SystemDirectories.change_directory(directory)
    end
  end
end
