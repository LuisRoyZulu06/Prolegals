defmodule ProlegalsWeb.SecurityController do
    use ProlegalsWeb, :controller

    alias Prolegals.Security
    alias Prolegals.Security.LogBook
    alias Prolegals.{Logs, Repo, Logs.UserLogs, Auth}
    alias Prolegals.Accounts
    alias Prolegals.Accounts.User

    def list_log_book_users(conn, _params) do
      list_log_book_users = Security.list_sec_tbl_log_book()
      render(conn, "list_log_book_users.html", list_log_book_users: list_log_book_users)
    end

    def create_log_book_user(conn, params) do
      IO.inspect "###################################### start s#####"
      IO.inspect params
      case Security.create_log_book(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "New User Added To System")
            |> redirect(to: Routes.user_path(conn, :dashboard))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add New User To system.")
            |> redirect(to: Routes.user_path(conn, :dashboard))
      end
  end


   def add_time_out(conn, %{"id" => id} = params) do
    list_log_book_user = Security.get_log_book!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:list_log_book_user, LogBook.changeset(list_log_book_user, params))
      |> Ecto.Multi.run(:userlogs, fn %{list_log_book_user: list_log_book_user} ->
        activity = "Prolegals Timeout updated with ID \"#{list_log_book_user.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{list_log_book_user: _list_log_book_user, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "Time Out successfully updated:-) ")
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))
      end

  end

  def traverse_errors(errors) do
    for {key, {msg, _opts}} <- errors, do: "#{key} #{msg}"
  end



end
