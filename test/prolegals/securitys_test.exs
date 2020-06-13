defmodule Prolegals.SecuritysTest do
  use Prolegals.DataCase

  alias Prolegals.Securitys

  describe "tbl_log_book" do
    alias Prolegals.Securitys.Log_book

    @valid_attrs %{address: "some address", company: "some company", date: "some date", id_no: "some id_no", id_type: "some id_type", image: "some image", mobile_no: "some mobile_no", name: "some name", person_to_see: "some person_to_see", purpose: "some purpose", sex: "some sex", time_in: "some time_in", time_out: "some time_out"}
    @update_attrs %{address: "some updated address", company: "some updated company", date: "some updated date", id_no: "some updated id_no", id_type: "some updated id_type", image: "some updated image", mobile_no: "some updated mobile_no", name: "some updated name", person_to_see: "some updated person_to_see", purpose: "some updated purpose", sex: "some updated sex", time_in: "some updated time_in", time_out: "some updated time_out"}
    @invalid_attrs %{address: nil, company: nil, date: nil, id_no: nil, id_type: nil, image: nil, mobile_no: nil, name: nil, person_to_see: nil, purpose: nil, sex: nil, time_in: nil, time_out: nil}

    def log_book_fixture(attrs \\ %{}) do
      {:ok, log_book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Securitys.create_log_book()

      log_book
    end

    test "list_tbl_log_book/0 returns all tbl_log_book" do
      log_book = log_book_fixture()
      assert Securitys.list_tbl_log_book() == [log_book]
    end

    test "get_log_book!/1 returns the log_book with given id" do
      log_book = log_book_fixture()
      assert Securitys.get_log_book!(log_book.id) == log_book
    end

    test "create_log_book/1 with valid data creates a log_book" do
      assert {:ok, %Log_book{} = log_book} = Securitys.create_log_book(@valid_attrs)
      assert log_book.address == "some address"
      assert log_book.company == "some company"
      assert log_book.date == "some date"
      assert log_book.id_no == "some id_no"
      assert log_book.id_type == "some id_type"
      assert log_book.image == "some image"
      assert log_book.mobile_no == "some mobile_no"
      assert log_book.name == "some name"
      assert log_book.person_to_see == "some person_to_see"
      assert log_book.purpose == "some purpose"
      assert log_book.sex == "some sex"
      assert log_book.time_in == "some time_in"
      assert log_book.time_out == "some time_out"
    end

    test "create_log_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Securitys.create_log_book(@invalid_attrs)
    end

    test "update_log_book/2 with valid data updates the log_book" do
      log_book = log_book_fixture()
      assert {:ok, %Log_book{} = log_book} = Securitys.update_log_book(log_book, @update_attrs)
      assert log_book.address == "some updated address"
      assert log_book.company == "some updated company"
      assert log_book.date == "some updated date"
      assert log_book.id_no == "some updated id_no"
      assert log_book.id_type == "some updated id_type"
      assert log_book.image == "some updated image"
      assert log_book.mobile_no == "some updated mobile_no"
      assert log_book.name == "some updated name"
      assert log_book.person_to_see == "some updated person_to_see"
      assert log_book.purpose == "some updated purpose"
      assert log_book.sex == "some updated sex"
      assert log_book.time_in == "some updated time_in"
      assert log_book.time_out == "some updated time_out"
    end

    test "update_log_book/2 with invalid data returns error changeset" do
      log_book = log_book_fixture()
      assert {:error, %Ecto.Changeset{}} = Securitys.update_log_book(log_book, @invalid_attrs)
      assert log_book == Securitys.get_log_book!(log_book.id)
    end

    test "delete_log_book/1 deletes the log_book" do
      log_book = log_book_fixture()
      assert {:ok, %Log_book{}} = Securitys.delete_log_book(log_book)
      assert_raise Ecto.NoResultsError, fn -> Securitys.get_log_book!(log_book.id) end
    end

    test "change_log_book/1 returns a log_book changeset" do
      log_book = log_book_fixture()
      assert %Ecto.Changeset{} = Securitys.change_log_book(log_book)
    end
  end
end
