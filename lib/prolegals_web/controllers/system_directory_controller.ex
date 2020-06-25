defmodule ProlegalsWeb.SystemDirectoryController do
  use ProlegalsWeb, :controller
  alias Prolegals.Repo
  alias Prolegals.SystemDirectories
  alias Prolegals.SystemDirectories.Directory
  alias ProlegalsWeb.UserController
  alias Prolegals.Logs.UserLogs

  plug(
    ProlegalsWeb.Plugs.RequireAuth
    when action in [:create, :index ])


  def index(conn, _params) do
      sys_dirs = SystemDirectories.directories()
      render(conn, "index.html", sys_dirs: sys_dirs)
  end

  def create(conn, params) do
      sys_dirs = params["id"] != "" && SystemDirectories.directories() || %Directory{}
      Ecto.Multi.new()
      |> Ecto.Multi.insert_or_update(:sys_dirs, Directory.changeset(sys_dirs, params))
      |> Ecto.Multi.run(:user_log, fn %{sys_dirs: _sys_dirs} ->
        activity = "Created/Updated with system directories information"
        UserLogs.changeset(%UserLogs{}, %{
          user_id: conn.assigns.user.id,
          activity: activity
        })
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{sys_dirs: _sys_dirs, user_log: _user_log}} ->
          conn
          |> put_flash(:info, "Operation successful!")
          |> redirect(to: Routes.system_directory_path(conn, :index))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = UserController.traverse_errors(failed_value.errors) |> Enum.join("\r\n")

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.system_directory_path(conn, :index))
      end
  # rescue
  # _ ->
  #     conn
  #     |> put_flash(:error, "An error occurred, reason unknown. try again")
  #     |> redirect(to: Routes.system_directory_path(conn, :index))
   end
end
