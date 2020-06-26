defmodule ProlegalsWeb.AdminController do
  use ProlegalsWeb, :controller

  alias Prolegals.{Logs, Repo, Logs.UserLogs, Auth}
  alias Prolegals.Security
  alias Prolegals.Security.Inventory
  alias Prolegals.Security.Asset

  def index(conn, _params) do
    render(conn, "index.html")
  end


  #------------------------------Inventory controller

  def inventory(conn, _params) do
    inventories = Security.list_sec_tbl_inventory_categories()
    render(conn, "inventory.html", inventories: inventories)
  end

  def view_assets(conn, %{"id" => id}) do
    inventories = Security.get_inventory!(id)
    render(conn, "view_assets.html", inventories: inventories)
  end

  def create_inventory(conn, params) do
  	case Security.create_inventory(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "A New Inventory Category Has Been Added Successfully.")
            |> redirect(to: Routes.admin_path(conn, :inventory))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add A New Category!")
            |> redirect(to: Routes.admin_path(conn, :inventory))
    end
  end

  def update_inventory(conn, %{"id" => id} = params) do
    inventories = Security.get_inventory!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:inventories, Inventory.changeset(inventories, params))
    |> Ecto.Multi.run(:userlogs, fn %{inventories: inventories} ->
      activity = "Category updated with ID \"#{inventories.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{inventories: _inventories, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "Category Has Been Updated Successfully")
        |> redirect(to: Routes.admin_path(conn, :inventory))

        {:error, %{firearms: _firearms, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed To Update Category Details.")
          |> redirect(to: Routes.admin_path(conn, :inventory))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
      end
  end

  def delete_inventory(conn, %{"id" => id}) do
    inventories = Security.get_inventory!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.delete(:inventories, inventories)
    |> Ecto.Multi.run(:userlogs, fn %{inventories: inventories} ->
      activity = "Category Deleted \"#{inventories.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{inventories: _inventories, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "Category Has Been Deleted.")
        |> redirect(to: Routes.admin_path(conn, :inventory))

      # {:error, _failed_operation, failed_value, _changes_so_far} ->
      #  reason = AdminController._traverse_errors(failed_value.errors) |> List.first()

      #  conn
      #  |> put_flash(:error, reason)
      #  |> redirect(to: Routes.admin_path(conn, :inventory))
    end
  end

  # ------------------------------------ Assets Controller

  def asset(conn, _params) do
    assets = Security.list_sec_tbl_assets()
    inventories = Security.list_sec_tbl_inventory_categories()
    render(conn, "assets.html", assets: assets, inventories: inventories)
  end

  def view_asset(conn, %{"id" => id}) do
    IO.inspect "=========================================================="
    IO.inspect id
    assets = Security.list_sec_tbl_assets()
    inventories = Security.list_sec_tbl_inventory_categories()
    bluh = Security.get_asset_by_category(id)
    render(conn, "view_assets.html", assets: assets, inventories: inventories, bluh: bluh)
  end


  def create_asset(conn, params) do
    IO.inspect "=========================================================="
    IO.inspect conn
  	case Security.create_asset(Map.put(params, "asset_id", params["category_id"])) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "A New Asset Has Been Added successfully.")
            |> redirect(to: Routes.admin_path(conn, :asset))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add Asset!")
            |> redirect(to: Routes.admin_path(conn, :asset))
    end
  end

  def update_asset(conn, %{"id" => id} = params) do
    assets = Security.get_asset!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:assets, Asset.changeset(assets, params))
    |> Ecto.Multi.run(:userlogs, fn %{assets: assets} ->
      activity = "Asset updated with ID \"#{assets.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{assets: _assets, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "The Asset Has Been Updated Successfully")
        |> redirect(to: Routes.admin_path(conn, :asset))

        {:error, %{firearms: _firearms, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed To uUpdate The Asset details.")
          |> redirect(to: Routes.admin_path(conn, :asset))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
      end
  end

  def delete_asset(conn, %{"id" => id}) do
    assets = Security.get_asset!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.delete(:assets, assets)
    |> Ecto.Multi.run(:userlogs, fn %{assets: assets} ->
      activity = "Asset Deleted \"#{assets.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{assets: _assets, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "Asset Deleted.")
        |> redirect(to: Routes.admin_path(conn, :asset))

      # {:error, _failed_operation, failed_value, _changes_so_far} ->
      #  reason = AdminController._traverse_errors(failed_value.errors) |> List.first()

      #  conn
      #  |> put_flash(:error, reason)
      #  |> redirect(to: Routes.admin_path(conn, :inventory))
    end
  end

end
