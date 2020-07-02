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

  describe "sec_tbl_categories" do
    alias Prolegals.Security.CategoriesInventory

    @valid_attrs %{category_code: "some category_code", name: "some name"}
    @update_attrs %{category_code: "some updated category_code", name: "some updated name"}
    @invalid_attrs %{category_code: nil, name: nil}

    def categories_inventory_fixture(attrs \\ %{}) do
      {:ok, categories_inventory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_categories_inventory()

      categories_inventory
    end

    test "list_sec_tbl_categories/0 returns all sec_tbl_categories" do
      categories_inventory = categories_inventory_fixture()
      assert Security.list_sec_tbl_categories() == [categories_inventory]
    end

    test "get_categories_inventory!/1 returns the categories_inventory with given id" do
      categories_inventory = categories_inventory_fixture()
      assert Security.get_categories_inventory!(categories_inventory.id) == categories_inventory
    end

    test "create_categories_inventory/1 with valid data creates a categories_inventory" do
      assert {:ok, %CategoriesInventory{} = categories_inventory} = Security.create_categories_inventory(@valid_attrs)
      assert categories_inventory.category_code == "some category_code"
      assert categories_inventory.name == "some name"
    end

    test "create_categories_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_categories_inventory(@invalid_attrs)
    end

    test "update_categories_inventory/2 with valid data updates the categories_inventory" do
      categories_inventory = categories_inventory_fixture()
      assert {:ok, %CategoriesInventory{} = categories_inventory} = Security.update_categories_inventory(categories_inventory, @update_attrs)
      assert categories_inventory.category_code == "some updated category_code"
      assert categories_inventory.name == "some updated name"
    end

    test "update_categories_inventory/2 with invalid data returns error changeset" do
      categories_inventory = categories_inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_categories_inventory(categories_inventory, @invalid_attrs)
      assert categories_inventory == Security.get_categories_inventory!(categories_inventory.id)
    end

    test "delete_categories_inventory/1 deletes the categories_inventory" do
      categories_inventory = categories_inventory_fixture()
      assert {:ok, %CategoriesInventory{}} = Security.delete_categories_inventory(categories_inventory)
      assert_raise Ecto.NoResultsError, fn -> Security.get_categories_inventory!(categories_inventory.id) end
    end

    test "change_categories_inventory/1 returns a categories_inventory changeset" do
      categories_inventory = categories_inventory_fixture()
      assert %Ecto.Changeset{} = Security.change_categories_inventory(categories_inventory)
    end
  end

  describe "sec_tbl_inventory_categories" do
    alias Prolegals.Security.Inventory

    @valid_attrs %{category_code: "some category_code", name: "some name"}
    @update_attrs %{category_code: "some updated category_code", name: "some updated name"}
    @invalid_attrs %{category_code: nil, name: nil}

    def inventory_fixture(attrs \\ %{}) do
      {:ok, inventory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_inventory()

      inventory
    end

    test "list_sec_tbl_inventory_categories/0 returns all sec_tbl_inventory_categories" do
      inventory = inventory_fixture()
      assert Security.list_sec_tbl_inventory_categories() == [inventory]
    end

    test "get_inventory!/1 returns the inventory with given id" do
      inventory = inventory_fixture()
      assert Security.get_inventory!(inventory.id) == inventory
    end

    test "create_inventory/1 with valid data creates a inventory" do
      assert {:ok, %Inventory{} = inventory} = Security.create_inventory(@valid_attrs)
      assert inventory.category_code == "some category_code"
      assert inventory.name == "some name"
    end

    test "create_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_inventory(@invalid_attrs)
    end

    test "update_inventory/2 with valid data updates the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{} = inventory} = Security.update_inventory(inventory, @update_attrs)
      assert inventory.category_code == "some updated category_code"
      assert inventory.name == "some updated name"
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

  describe "sec_tbl_assets" do
    alias Prolegals.Security.Assets

    @valid_attrs %{brand: "some brand", category_id: "some category_id", date_purchased: "some date_purchased", make_year: "some make_year", name: "some name", purchased_from: "some purchased_from", quantity: "some quantity", serial_number: "some serial_number", status: "some status", type: "some type"}
    @update_attrs %{brand: "some updated brand", category_id: "some updated category_id", date_purchased: "some updated date_purchased", make_year: "some updated make_year", name: "some updated name", purchased_from: "some updated purchased_from", quantity: "some updated quantity", serial_number: "some updated serial_number", status: "some updated status", type: "some updated type"}
    @invalid_attrs %{brand: nil, category_id: nil, date_purchased: nil, make_year: nil, name: nil, purchased_from: nil, quantity: nil, serial_number: nil, status: nil, type: nil}

    def assets_fixture(attrs \\ %{}) do
      {:ok, assets} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_assets()

      assets
    end

    test "list_sec_tbl_assets/0 returns all sec_tbl_assets" do
      assets = assets_fixture()
      assert Security.list_sec_tbl_assets() == [assets]
    end

    test "get_assets!/1 returns the assets with given id" do
      assets = assets_fixture()
      assert Security.get_assets!(assets.id) == assets
    end

    test "create_assets/1 with valid data creates a assets" do
      assert {:ok, %Assets{} = assets} = Security.create_assets(@valid_attrs)
      assert assets.brand == "some brand"
      assert assets.category_id == "some category_id"
      assert assets.date_purchased == "some date_purchased"
      assert assets.make_year == "some make_year"
      assert assets.name == "some name"
      assert assets.purchased_from == "some purchased_from"
      assert assets.quantity == "some quantity"
      assert assets.serial_number == "some serial_number"
      assert assets.status == "some status"
      assert assets.type == "some type"
    end

    test "create_assets/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_assets(@invalid_attrs)
    end

    test "update_assets/2 with valid data updates the assets" do
      assets = assets_fixture()
      assert {:ok, %Assets{} = assets} = Security.update_assets(assets, @update_attrs)
      assert assets.brand == "some updated brand"
      assert assets.category_id == "some updated category_id"
      assert assets.date_purchased == "some updated date_purchased"
      assert assets.make_year == "some updated make_year"
      assert assets.name == "some updated name"
      assert assets.purchased_from == "some updated purchased_from"
      assert assets.quantity == "some updated quantity"
      assert assets.serial_number == "some updated serial_number"
      assert assets.status == "some updated status"
      assert assets.type == "some updated type"
    end

    test "update_assets/2 with invalid data returns error changeset" do
      assets = assets_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_assets(assets, @invalid_attrs)
      assert assets == Security.get_assets!(assets.id)
    end

    test "delete_assets/1 deletes the assets" do
      assets = assets_fixture()
      assert {:ok, %Assets{}} = Security.delete_assets(assets)
      assert_raise Ecto.NoResultsError, fn -> Security.get_assets!(assets.id) end
    end

    test "change_assets/1 returns a assets changeset" do
      assets = assets_fixture()
      assert %Ecto.Changeset{} = Security.change_assets(assets)
    end
  end

  describe "sec_tbl_assets" do
    alias Prolegals.Security.Asset

    @valid_attrs %{brand: "some brand", category_id: "some category_id", date_purchased: "some date_purchased", make_year: "some make_year", name: "some name", purchased_from: "some purchased_from", quantity: "some quantity", serial_number: "some serial_number", status: "some status", type: "some type"}
    @update_attrs %{brand: "some updated brand", category_id: "some updated category_id", date_purchased: "some updated date_purchased", make_year: "some updated make_year", name: "some updated name", purchased_from: "some updated purchased_from", quantity: "some updated quantity", serial_number: "some updated serial_number", status: "some updated status", type: "some updated type"}
    @invalid_attrs %{brand: nil, category_id: nil, date_purchased: nil, make_year: nil, name: nil, purchased_from: nil, quantity: nil, serial_number: nil, status: nil, type: nil}

    def asset_fixture(attrs \\ %{}) do
      {:ok, asset} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_asset()

      asset
    end

    test "list_sec_tbl_assets/0 returns all sec_tbl_assets" do
      asset = asset_fixture()
      assert Security.list_sec_tbl_assets() == [asset]
    end

    test "get_asset!/1 returns the asset with given id" do
      asset = asset_fixture()
      assert Security.get_asset!(asset.id) == asset
    end

    test "create_asset/1 with valid data creates a asset" do
      assert {:ok, %Asset{} = asset} = Security.create_asset(@valid_attrs)
      assert asset.brand == "some brand"
      assert asset.category_id == "some category_id"
      assert asset.date_purchased == "some date_purchased"
      assert asset.make_year == "some make_year"
      assert asset.name == "some name"
      assert asset.purchased_from == "some purchased_from"
      assert asset.quantity == "some quantity"
      assert asset.serial_number == "some serial_number"
      assert asset.status == "some status"
      assert asset.type == "some type"
    end

    test "create_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_asset(@invalid_attrs)
    end

    test "update_asset/2 with valid data updates the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{} = asset} = Security.update_asset(asset, @update_attrs)
      assert asset.brand == "some updated brand"
      assert asset.category_id == "some updated category_id"
      assert asset.date_purchased == "some updated date_purchased"
      assert asset.make_year == "some updated make_year"
      assert asset.name == "some updated name"
      assert asset.purchased_from == "some updated purchased_from"
      assert asset.quantity == "some updated quantity"
      assert asset.serial_number == "some updated serial_number"
      assert asset.status == "some updated status"
      assert asset.type == "some updated type"
    end

    test "update_asset/2 with invalid data returns error changeset" do
      asset = asset_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_asset(asset, @invalid_attrs)
      assert asset == Security.get_asset!(asset.id)
    end

    test "delete_asset/1 deletes the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{}} = Security.delete_asset(asset)
      assert_raise Ecto.NoResultsError, fn -> Security.get_asset!(asset.id) end
    end

    test "change_asset/1 returns a asset changeset" do
      asset = asset_fixture()
      assert %Ecto.Changeset{} = Security.change_asset(asset)
    end
  end

  describe "sec_tbl_location" do
    alias Prolegals.Security.Location

    @valid_attrs %{address: "some address", contact: "some contact", contact_person: "some contact_person", email: "some email", office_name: "some office_name", province: "some province"}
    @update_attrs %{address: "some updated address", contact: "some updated contact", contact_person: "some updated contact_person", email: "some updated email", office_name: "some updated office_name", province: "some updated province"}
    @invalid_attrs %{address: nil, contact: nil, contact_person: nil, email: nil, office_name: nil, province: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_location()

      location
    end

    test "list_sec_tbl_location/0 returns all sec_tbl_location" do
      location = location_fixture()
      assert Security.list_sec_tbl_location() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Security.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Security.create_location(@valid_attrs)
      assert location.address == "some address"
      assert location.contact == "some contact"
      assert location.contact_person == "some contact_person"
      assert location.email == "some email"
      assert location.office_name == "some office_name"
      assert location.province == "some province"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, %Location{} = location} = Security.update_location(location, @update_attrs)
      assert location.address == "some updated address"
      assert location.contact == "some updated contact"
      assert location.contact_person == "some updated contact_person"
      assert location.email == "some updated email"
      assert location.office_name == "some updated office_name"
      assert location.province == "some updated province"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_location(location, @invalid_attrs)
      assert location == Security.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Security.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Security.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Security.change_location(location)
    end
  end

  describe "sec_tbl_vendor" do
    alias Prolegals.Security.Vendor

    @valid_attrs %{address: "some address", contact: "some contact", contact_person: "some contact_person", country: "some country", email: "some email", vendor_name: "some vendor_name"}
    @update_attrs %{address: "some updated address", contact: "some updated contact", contact_person: "some updated contact_person", country: "some updated country", email: "some updated email", vendor_name: "some updated vendor_name"}
    @invalid_attrs %{address: nil, contact: nil, contact_person: nil, country: nil, email: nil, vendor_name: nil}

    def vendor_fixture(attrs \\ %{}) do
      {:ok, vendor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_vendor()

      vendor
    end

    test "list_sec_tbl_vendor/0 returns all sec_tbl_vendor" do
      vendor = vendor_fixture()
      assert Security.list_sec_tbl_vendor() == [vendor]
    end

    test "get_vendor!/1 returns the vendor with given id" do
      vendor = vendor_fixture()
      assert Security.get_vendor!(vendor.id) == vendor
    end

    test "create_vendor/1 with valid data creates a vendor" do
      assert {:ok, %Vendor{} = vendor} = Security.create_vendor(@valid_attrs)
      assert vendor.address == "some address"
      assert vendor.contact == "some contact"
      assert vendor.contact_person == "some contact_person"
      assert vendor.country == "some country"
      assert vendor.email == "some email"
      assert vendor.vendor_name == "some vendor_name"
    end

    test "create_vendor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_vendor(@invalid_attrs)
    end

    test "update_vendor/2 with valid data updates the vendor" do
      vendor = vendor_fixture()
      assert {:ok, %Vendor{} = vendor} = Security.update_vendor(vendor, @update_attrs)
      assert vendor.address == "some updated address"
      assert vendor.contact == "some updated contact"
      assert vendor.contact_person == "some updated contact_person"
      assert vendor.country == "some updated country"
      assert vendor.email == "some updated email"
      assert vendor.vendor_name == "some updated vendor_name"
    end

    test "update_vendor/2 with invalid data returns error changeset" do
      vendor = vendor_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_vendor(vendor, @invalid_attrs)
      assert vendor == Security.get_vendor!(vendor.id)
    end

    test "delete_vendor/1 deletes the vendor" do
      vendor = vendor_fixture()
      assert {:ok, %Vendor{}} = Security.delete_vendor(vendor)
      assert_raise Ecto.NoResultsError, fn -> Security.get_vendor!(vendor.id) end
    end

    test "change_vendor/1 returns a vendor changeset" do
      vendor = vendor_fixture()
      assert %Ecto.Changeset{} = Security.change_vendor(vendor)
    end
  end

  describe "sec_tbl_vendor" do
    alias Prolegals.Security.Employee

    @valid_attrs %{contact: "some contact", department: "some department", email: "some email", employee_name: "some employee_name", employee_no: "some employee_no", nrc: "some nrc"}
    @update_attrs %{contact: "some updated contact", department: "some updated department", email: "some updated email", employee_name: "some updated employee_name", employee_no: "some updated employee_no", nrc: "some updated nrc"}
    @invalid_attrs %{contact: nil, department: nil, email: nil, employee_name: nil, employee_no: nil, nrc: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_employee()

      employee
    end

    test "list_sec_tbl_vendor/0 returns all sec_tbl_vendor" do
      employee = employee_fixture()
      assert Security.list_sec_tbl_vendor() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Security.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Security.create_employee(@valid_attrs)
      assert employee.contact == "some contact"
      assert employee.department == "some department"
      assert employee.email == "some email"
      assert employee.employee_name == "some employee_name"
      assert employee.employee_no == "some employee_no"
      assert employee.nrc == "some nrc"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Security.update_employee(employee, @update_attrs)
      assert employee.contact == "some updated contact"
      assert employee.department == "some updated department"
      assert employee.email == "some updated email"
      assert employee.employee_name == "some updated employee_name"
      assert employee.employee_no == "some updated employee_no"
      assert employee.nrc == "some updated nrc"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_employee(employee, @invalid_attrs)
      assert employee == Security.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Security.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Security.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Security.change_employee(employee)
    end
  end

  describe "sec_tbl_employee" do
    alias Prolegals.Security.Employee

    @valid_attrs %{contact: "some contact", department: "some department", email: "some email", employee_name: "some employee_name", employee_no: "some employee_no", nrc: "some nrc"}
    @update_attrs %{contact: "some updated contact", department: "some updated department", email: "some updated email", employee_name: "some updated employee_name", employee_no: "some updated employee_no", nrc: "some updated nrc"}
    @invalid_attrs %{contact: nil, department: nil, email: nil, employee_name: nil, employee_no: nil, nrc: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Security.create_employee()

      employee
    end

    test "list_sec_tbl_employee/0 returns all sec_tbl_employee" do
      employee = employee_fixture()
      assert Security.list_sec_tbl_employee() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Security.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Security.create_employee(@valid_attrs)
      assert employee.contact == "some contact"
      assert employee.department == "some department"
      assert employee.email == "some email"
      assert employee.employee_name == "some employee_name"
      assert employee.employee_no == "some employee_no"
      assert employee.nrc == "some nrc"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Security.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Security.update_employee(employee, @update_attrs)
      assert employee.contact == "some updated contact"
      assert employee.department == "some updated department"
      assert employee.email == "some updated email"
      assert employee.employee_name == "some updated employee_name"
      assert employee.employee_no == "some updated employee_no"
      assert employee.nrc == "some updated nrc"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Security.update_employee(employee, @invalid_attrs)
      assert employee == Security.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Security.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Security.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Security.change_employee(employee)
    end
  end
end
