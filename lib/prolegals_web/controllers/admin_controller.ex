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
            |> put_flash(:info, "Inventory Category Added.")
            |> redirect(to: Routes.admin_path(conn, :inventory))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed to add Category!")
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
        |> put_flash(:info, "Category updated")
        |> redirect(to: Routes.admin_path(conn, :inventory))

        {:error, %{firearms: _firearms, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed to update Category details.")
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
        |> put_flash(:info, "Category Deleted.")
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

  def view_asset(conn, _params) do
    assets = Security.list_sec_tbl_assets()
    inventories = Security.list_sec_tbl_inventory_categories()
    render(conn, "view_assets.html", assets: assets, inventories: inventories)
  end

  def create_asset(conn, params) do
  	case Security.create_asset(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "Asset Added.")
            |> redirect(to: Routes.admin_path(conn, :asset))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed to add Asset!")
            |> redirect(to: Routes.admin_path(conn, :asset))
    end
  end

end
