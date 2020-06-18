defmodule ProlegalsWeb.AdminController do
  use ProlegalsWeb, :controller

  alias Prolegals.{Logs, Repo, Logs.UserLogs, Auth}
  alias Prolegals.Security
  alias Prolegals.Security.AmmunitionInventory
  alias Prolegals.Security.FirearmsInventory

  def index(conn, _params) do
    render(conn, "index.html")
  end


  #------------------------------create ammo ontroller

  def ammunition(conn, _params) do
    ammunitions = Security.list_sec_tbl_ammunition()
    render(conn, "ammunition.html", ammunitions: ammunitions)
  end

  def create_ammunition_inventory(conn, params) do
  	case Security.create_ammunition_inventory(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "Ammunition Added.")
            |> redirect(to: Routes.admin_path(conn, :ammunition))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed to add ammunition!")
            |> redirect(to: Routes.admin_path(conn, :ammunition))
    end
  end

  def update_ammunition_inventory(conn, %{"id" => id} = params) do
    ammunition = Security.get_ammunition_inventory!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:ammunition, AmmunitionInventory.changeset(ammunition, params))
    |> Ecto.Multi.run(:userlogs, fn %{ammunition: ammunition} ->
      activity = "Ammuntion updated with ID \"#{ammunition.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{ammunition: _ammunition, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "Ammunition updated")
        |> redirect(to: Routes.admin_path(conn, :ammunition))

        {:error, %{ammunition: _ammunition, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed to update ammunition details.")
          |> redirect(to: Routes.admin_path(conn, :ammunition))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
    end
end

def delete_ammunition_inventory(conn, %{"id" => id}) do
  ammunition = Security.get_ammunition_inventory!(id)

  Ecto.Multi.new()
  |> Ecto.Multi.delete(:ammunition, ammunition)
  |> Ecto.Multi.run(:userlogs, fn %{ammunition: ammunition} ->
    activity = "Ammunition Removed From Inventory with ID \"#{ammunition.id}\""

    userlogs = %{
      user_id: conn.assigns.user.id,
      activity: activity
    }

    UserLogs.changeset(%UserLogs{}, userlogs)
    |> Repo.insert()
  end)
  |> Repo.transaction()
  |> case do
    {:ok, %{ammunition: _ammunition, userlogs: _userlogs}} ->
      conn
      |> put_flash(:info, "Ammunition deleted from system.")
      |> redirect(to: Routes.admin_path(conn, :ammunition))

    # {:error, _failed_operation, failed_value, _changes_so_far} ->
    #  reason = AdminController._traverse_errors(failed_value.errors) |> List.first()

    #  conn
    #  |> put_flash(:error, reason)
    #  |> redirect(to: Routes.admin_path(conn, :ammunition))
  end
end

  #------------------------------create gun controller

  def firearm(conn, _params) do
    firearms = Security.list_sec_tbl_firearms()
    render(conn, "firearm.html", firearms: firearms)
  end

  def view_firearm(conn, _params) do
    firearms = Security.list_sec_tbl_firearms()
    render(conn, "view_firearm.html", firearms: firearms)
  end

  def create_firearms_inventory(conn, params) do
  	case Security.create_firearms_inventory(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "Firearm Added.")
            |> redirect(to: Routes.admin_path(conn, :firearm))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed to add Firearm!")
            |> redirect(to: Routes.admin_path(conn, :firearm))
    end
  end

  def update_firearms_inventory(conn, %{"id" => id} = params) do
    firearms = Security.get_firearms_inventory!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:firearms, FirearmsInventory.changeset(firearms, params))
    |> Ecto.Multi.run(:userlogs, fn %{firearms: firearms} ->
      activity = "firearms updated with ID \"#{firearms.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{firearms: _firearms, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "firearms updated")
        |> redirect(to: Routes.admin_path(conn, :firearm))

        {:error, %{firearms: _firearms, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed to update firearms details.")
          |> redirect(to: Routes.admin_path(conn, :firearm))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
      end
  end

    def delete_firearms_inventory(conn, %{"id" => id}) do
      firearms = Security.get_firearms_inventory!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.delete(:firearms, firearms)
      |> Ecto.Multi.run(:userlogs, fn %{firearms: firearms} ->
        activity = "Firearm Removed From Inventory with ID \"#{firearms.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{firearms: _firearms, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "Firearm deleted from system.")
          |> redirect(to: Routes.admin_path(conn, :firearm))

        # {:error, _failed_operation, failed_value, _changes_so_far} ->
        #  reason = AdminController._traverse_errors(failed_value.errors) |> List.first()

        #  conn
        #  |> put_flash(:error, reason)
        #  |> redirect(to: Routes.admin_path(conn, :ammunition))
      end
    end

end
