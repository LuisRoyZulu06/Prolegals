defmodule Prolegals.SecurityTest do
  use Prolegals.DataCase

  alias Prolegals.Security

  describe "sec_tbl_log_book" do
    alias Prolegals.Security.LogBook

    @valid_attrs %{address: "some address", company: "some company", date: "some date", id_no: "some id_no", id_type: "some id_type", image: "some image", mobile_no: "some mobile_no", name: "some name", person_to_see: "some person_to_see", purpose: "some purpose", sex: "some sex", time_in: "some time_in", time_out: "some time_out"}
    @update_attrs %{address: "some updated address", company: "some updated company", date: "some updated date", id_no: "some updated id_no", id_type: "some updated id_type", image: "some updated image", mobile_no: "some updated mobile_no", name: "some updated name", person_to_see: "some updated person_to_see", purpose: "some updated purpose", sex: "some updated sex", time_in: "some updated time_in", time_out: "some updated time_out"}
    @invalid_attrs %{address: nil, company: nil, date: nil, id_no: nil, id_type: nil, image: nil, mobile_no: nil, name: nil, person_to_see: nil, purpose: nil, sex: nil, time_in: nil, time_out: nil}

    def log_book_fixture(attrs \\ %{}) do
      {:ok, log_book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_log_book()

      log_book
    end

    test "list_sec_tbl_log_book/0 returns all sec_tbl_log_book" do
      log_book = log_book_fixture()
      assert Security.list_sec_tbl_log_book() == [log_book]
    end

    test "get_log_book!/1 returns the log_book with given id" do
      log_book = log_book_fixture()
      assert Security.get_log_book!(log_book.id) == log_book
    end

    test "create_log_book/1 with valid data creates a log_book" do
      assert {:ok, %LogBook{} = log_book} = Security.create_log_book(@valid_attrs)
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
      assert {:error, %Ecto.Changeset{}} = Security.create_log_book(@invalid_attrs)
    end

    test "update_log_book/2 with valid data updates the log_book" do
      log_book = log_book_fixture()
      assert {:ok, %LogBook{} = log_book} = Security.update_log_book(log_book, @update_attrs)
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
      assert {:error, %Ecto.Changeset{}} = Security.update_log_book(log_book, @invalid_attrs)
      assert log_book == Security.get_log_book!(log_book.id)
    end

    test "delete_log_book/1 deletes the log_book" do
      log_book = log_book_fixture()
      assert {:ok, %LogBook{}} = Security.delete_log_book(log_book)
      assert_raise Ecto.NoResultsError, fn -> Security.get_log_book!(log_book.id) end
    end

    test "change_log_book/1 returns a log_book changeset" do
      log_book = log_book_fixture()
      assert %Ecto.Changeset{} = Security.change_log_book(log_book)
    end
  end

  describe "sec_tbl_firearms" do
    alias Prolegals.Security.Inventory

    @valid_attrs %{brand: "some brand", bullet_id: "some bullet_id", date_purchased: "some date_purchased", firearm_image: "some firearm_image", make_year: "some make_year", model: "some model", name: "some name", person_assigned: "some person_assigned", purchase_price: "some purchase_price", purchased_from: "some purchased_from", rounds: "some rounds", serial_number: "some serial_number", status: "some status", type: "some type"}
    @update_attrs %{brand: "some updated brand", bullet_id: "some updated bullet_id", date_purchased: "some updated date_purchased", firearm_image: "some updated firearm_image", make_year: "some updated make_year", model: "some updated model", name: "some updated name", person_assigned: "some updated person_assigned", purchase_price: "some updated purchase_price", purchased_from: "some updated purchased_from", rounds: "some updated rounds", serial_number: "some updated serial_number", status: "some updated status", type: "some updated type"}
    @invalid_attrs %{brand: nil, bullet_id: nil, date_purchased: nil, firearm_image: nil, make_year: nil, model: nil, name: nil, person_assigned: nil, purchase_price: nil, purchased_from: nil, rounds: nil, serial_number: nil, status: nil, type: nil}

    def inventory_fixture(attrs \\ %{}) do
      {:ok, inventory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_inventory()

      inventory
    end

    test "list_sec_tbl_firearms/0 returns all sec_tbl_firearms" do
      inventory = inventory_fixture()
      assert Security.list_sec_tbl_firearms() == [inventory]
    end

    test "get_inventory!/1 returns the inventory with given id" do
      inventory = inventory_fixture()
      assert Security.get_inventory!(inventory.id) == inventory
    end

    test "create_inventory/1 with valid data creates a inventory" do
      assert {:ok, %Inventory{} = inventory} = Security.create_inventory(@valid_attrs)
      assert inventory.brand == "some brand"
      assert inventory.bullet_id == "some bullet_id"
      assert inventory.date_purchased == "some date_purchased"
      assert inventory.firearm_image == "some firearm_image"
      assert inventory.make_year == "some make_year"
      assert inventory.model == "some model"
      assert inventory.name == "some name"
      assert inventory.person_assigned == "some person_assigned"
      assert inventory.purchase_price == "some purchase_price"
      assert inventory.purchased_from == "some purchased_from"
      assert inventory.rounds == "some rounds"
      assert inventory.serial_number == "some serial_number"
      assert inventory.status == "some status"
      assert inventory.type == "some type"
    end

    test "create_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_inventory(@invalid_attrs)
    end

    test "update_inventory/2 with valid data updates the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{} = inventory} = Security.update_inventory(inventory, @update_attrs)
      assert inventory.brand == "some updated brand"
      assert inventory.bullet_id == "some updated bullet_id"
      assert inventory.date_purchased == "some updated date_purchased"
      assert inventory.firearm_image == "some updated firearm_image"
      assert inventory.make_year == "some updated make_year"
      assert inventory.model == "some updated model"
      assert inventory.name == "some updated name"
      assert inventory.person_assigned == "some updated person_assigned"
      assert inventory.purchase_price == "some updated purchase_price"
      assert inventory.purchased_from == "some updated purchased_from"
      assert inventory.rounds == "some updated rounds"
      assert inventory.serial_number == "some updated serial_number"
      assert inventory.status == "some updated status"
      assert inventory.type == "some updated type"
    end

    test "update_inventory/2 with invalid data returns error changeset" do
      inventory = inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_inventory(inventory, @invalid_attrs)
      assert inventory == Security.get_inventory!(inventory.id)
    end

    test "delete_inventory/1 deletes the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{}} = Security.delete_inventory(inventory)
      assert_raise Ecto.NoResultsError, fn -> Security.get_inventory!(inventory.id) end
    end

    test "change_inventory/1 returns a inventory changeset" do
      inventory = inventory_fixture()
      assert %Ecto.Changeset{} = Security.change_inventory(inventory)
    end
  end

  describe "sec_tbl_ammunition" do
    alias Prolegals.Security.Inventory

    @valid_attrs %{caliber: "some caliber", firearm_serial_number: "some firearm_serial_number", quantity: "some quantity", serial_number: "some serial_number", type: "some type"}
    @update_attrs %{caliber: "some updated caliber", firearm_serial_number: "some updated firearm_serial_number", quantity: "some updated quantity", serial_number: "some updated serial_number", type: "some updated type"}
    @invalid_attrs %{caliber: nil, firearm_serial_number: nil, quantity: nil, serial_number: nil, type: nil}

    def inventory_fixture(attrs \\ %{}) do
      {:ok, inventory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_inventory()

      inventory
    end

    test "list_sec_tbl_ammunition/0 returns all sec_tbl_ammunition" do
      inventory = inventory_fixture()
      assert Security.list_sec_tbl_ammunition() == [inventory]
    end

    test "get_inventory!/1 returns the inventory with given id" do
      inventory = inventory_fixture()
      assert Security.get_inventory!(inventory.id) == inventory
    end

    test "create_inventory/1 with valid data creates a inventory" do
      assert {:ok, %Inventory{} = inventory} = Security.create_inventory(@valid_attrs)
      assert inventory.caliber == "some caliber"
      assert inventory.firearm_serial_number == "some firearm_serial_number"
      assert inventory.quantity == "some quantity"
      assert inventory.serial_number == "some serial_number"
      assert inventory.type == "some type"
    end

    test "create_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_inventory(@invalid_attrs)
    end

    test "update_inventory/2 with valid data updates the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{} = inventory} = Security.update_inventory(inventory, @update_attrs)
      assert inventory.caliber == "some updated caliber"
      assert inventory.firearm_serial_number == "some updated firearm_serial_number"
      assert inventory.quantity == "some updated quantity"
      assert inventory.serial_number == "some updated serial_number"
      assert inventory.type == "some updated type"
    end

    test "update_inventory/2 with invalid data returns error changeset" do
      inventory = inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_inventory(inventory, @invalid_attrs)
      assert inventory == Security.get_inventory!(inventory.id)
    end

    test "delete_inventory/1 deletes the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{}} = Security.delete_inventory(inventory)
      assert_raise Ecto.NoResultsError, fn -> Security.get_inventory!(inventory.id) end
    end

    test "change_inventory/1 returns a inventory changeset" do
      inventory = inventory_fixture()
      assert %Ecto.Changeset{} = Security.change_inventory(inventory)
    end
  end

  describe "sec_tbl_firearms" do
    alias Prolegals.Security.FirearmsInventory

    @valid_attrs %{brand: "some brand", bullet_id: "some bullet_id", date_purchased: "some date_purchased", firearm_image: "some firearm_image", make_year: "some make_year", model: "some model", name: "some name", person_assigned: "some person_assigned", purchase_price: "some purchase_price", purchased_from: "some purchased_from", rounds: "some rounds", serial_number: "some serial_number", status: "some status", type: "some type"}
    @update_attrs %{brand: "some updated brand", bullet_id: "some updated bullet_id", date_purchased: "some updated date_purchased", firearm_image: "some updated firearm_image", make_year: "some updated make_year", model: "some updated model", name: "some updated name", person_assigned: "some updated person_assigned", purchase_price: "some updated purchase_price", purchased_from: "some updated purchased_from", rounds: "some updated rounds", serial_number: "some updated serial_number", status: "some updated status", type: "some updated type"}
    @invalid_attrs %{brand: nil, bullet_id: nil, date_purchased: nil, firearm_image: nil, make_year: nil, model: nil, name: nil, person_assigned: nil, purchase_price: nil, purchased_from: nil, rounds: nil, serial_number: nil, status: nil, type: nil}

    def firearms_inventory_fixture(attrs \\ %{}) do
      {:ok, firearms_inventory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_firearms_inventory()

      firearms_inventory
    end

    test "list_sec_tbl_firearms/0 returns all sec_tbl_firearms" do
      firearms_inventory = firearms_inventory_fixture()
      assert Security.list_sec_tbl_firearms() == [firearms_inventory]
    end

    test "get_firearms_inventory!/1 returns the firearms_inventory with given id" do
      firearms_inventory = firearms_inventory_fixture()
      assert Security.get_firearms_inventory!(firearms_inventory.id) == firearms_inventory
    end

    test "create_firearms_inventory/1 with valid data creates a firearms_inventory" do
      assert {:ok, %FirearmsInventory{} = firearms_inventory} = Security.create_firearms_inventory(@valid_attrs)
      assert firearms_inventory.brand == "some brand"
      assert firearms_inventory.bullet_id == "some bullet_id"
      assert firearms_inventory.date_purchased == "some date_purchased"
      assert firearms_inventory.firearm_image == "some firearm_image"
      assert firearms_inventory.make_year == "some make_year"
      assert firearms_inventory.model == "some model"
      assert firearms_inventory.name == "some name"
      assert firearms_inventory.person_assigned == "some person_assigned"
      assert firearms_inventory.purchase_price == "some purchase_price"
      assert firearms_inventory.purchased_from == "some purchased_from"
      assert firearms_inventory.rounds == "some rounds"
      assert firearms_inventory.serial_number == "some serial_number"
      assert firearms_inventory.status == "some status"
      assert firearms_inventory.type == "some type"
    end

    test "create_firearms_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_firearms_inventory(@invalid_attrs)
    end

    test "update_firearms_inventory/2 with valid data updates the firearms_inventory" do
      firearms_inventory = firearms_inventory_fixture()
      assert {:ok, %FirearmsInventory{} = firearms_inventory} = Security.update_firearms_inventory(firearms_inventory, @update_attrs)
      assert firearms_inventory.brand == "some updated brand"
      assert firearms_inventory.bullet_id == "some updated bullet_id"
      assert firearms_inventory.date_purchased == "some updated date_purchased"
      assert firearms_inventory.firearm_image == "some updated firearm_image"
      assert firearms_inventory.make_year == "some updated make_year"
      assert firearms_inventory.model == "some updated model"
      assert firearms_inventory.name == "some updated name"
      assert firearms_inventory.person_assigned == "some updated person_assigned"
      assert firearms_inventory.purchase_price == "some updated purchase_price"
      assert firearms_inventory.purchased_from == "some updated purchased_from"
      assert firearms_inventory.rounds == "some updated rounds"
      assert firearms_inventory.serial_number == "some updated serial_number"
      assert firearms_inventory.status == "some updated status"
      assert firearms_inventory.type == "some updated type"
    end

    test "update_firearms_inventory/2 with invalid data returns error changeset" do
      firearms_inventory = firearms_inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_firearms_inventory(firearms_inventory, @invalid_attrs)
      assert firearms_inventory == Security.get_firearms_inventory!(firearms_inventory.id)
    end

    test "delete_firearms_inventory/1 deletes the firearms_inventory" do
      firearms_inventory = firearms_inventory_fixture()
      assert {:ok, %FirearmsInventory{}} = Security.delete_firearms_inventory(firearms_inventory)
      assert_raise Ecto.NoResultsError, fn -> Security.get_firearms_inventory!(firearms_inventory.id) end
    end

    test "change_firearms_inventory/1 returns a firearms_inventory changeset" do
      firearms_inventory = firearms_inventory_fixture()
      assert %Ecto.Changeset{} = Security.change_firearms_inventory(firearms_inventory)
    end
  end

  describe "sec_tbl_ammunition" do
    alias Prolegals.Security.AmmunitionInventory

    @valid_attrs %{caliber: "some caliber", firearm_serial_number: "some firearm_serial_number", quantity: "some quantity", serial_number: "some serial_number", type: "some type"}
    @update_attrs %{caliber: "some updated caliber", firearm_serial_number: "some updated firearm_serial_number", quantity: "some updated quantity", serial_number: "some updated serial_number", type: "some updated type"}
    @invalid_attrs %{caliber: nil, firearm_serial_number: nil, quantity: nil, serial_number: nil, type: nil}

    def ammunition_inventory_fixture(attrs \\ %{}) do
      {:ok, ammunition_inventory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_ammunition_inventory()

      ammunition_inventory
    end

    test "list_sec_tbl_ammunition/0 returns all sec_tbl_ammunition" do
      ammunition_inventory = ammunition_inventory_fixture()
      assert Security.list_sec_tbl_ammunition() == [ammunition_inventory]
    end

    test "get_ammunition_inventory!/1 returns the ammunition_inventory with given id" do
      ammunition_inventory = ammunition_inventory_fixture()
      assert Security.get_ammunition_inventory!(ammunition_inventory.id) == ammunition_inventory
    end

    test "create_ammunition_inventory/1 with valid data creates a ammunition_inventory" do
      assert {:ok, %AmmunitionInventory{} = ammunition_inventory} = Security.create_ammunition_inventory(@valid_attrs)
      assert ammunition_inventory.caliber == "some caliber"
      assert ammunition_inventory.firearm_serial_number == "some firearm_serial_number"
      assert ammunition_inventory.quantity == "some quantity"
      assert ammunition_inventory.serial_number == "some serial_number"
      assert ammunition_inventory.type == "some type"
    end

    test "create_ammunition_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_ammunition_inventory(@invalid_attrs)
    end

    test "update_ammunition_inventory/2 with valid data updates the ammunition_inventory" do
      ammunition_inventory = ammunition_inventory_fixture()
      assert {:ok, %AmmunitionInventory{} = ammunition_inventory} = Security.update_ammunition_inventory(ammunition_inventory, @update_attrs)
      assert ammunition_inventory.caliber == "some updated caliber"
      assert ammunition_inventory.firearm_serial_number == "some updated firearm_serial_number"
      assert ammunition_inventory.quantity == "some updated quantity"
      assert ammunition_inventory.serial_number == "some updated serial_number"
      assert ammunition_inventory.type == "some updated type"
    end

    test "update_ammunition_inventory/2 with invalid data returns error changeset" do
      ammunition_inventory = ammunition_inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_ammunition_inventory(ammunition_inventory, @invalid_attrs)
      assert ammunition_inventory == Security.get_ammunition_inventory!(ammunition_inventory.id)
    end

    test "delete_ammunition_inventory/1 deletes the ammunition_inventory" do
      ammunition_inventory = ammunition_inventory_fixture()
      assert {:ok, %AmmunitionInventory{}} = Security.delete_ammunition_inventory(ammunition_inventory)
      assert_raise Ecto.NoResultsError, fn -> Security.get_ammunition_inventory!(ammunition_inventory.id) end
    end

    test "change_ammunition_inventory/1 returns a ammunition_inventory changeset" do
      ammunition_inventory = ammunition_inventory_fixture()
      assert %Ecto.Changeset{} = Security.change_ammunition_inventory(ammunition_inventory)
    end
  end
end
