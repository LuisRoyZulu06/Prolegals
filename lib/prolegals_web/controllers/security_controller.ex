defmodule ProlegalsWeb.SecurityController do
    use ProlegalsWeb, :controller

    alias Prolegals.Security
    alias Prolegals.Security.LogBook
    alias Prolegals.{Logs, Repo, Logs.UserLogs, Auth}
    # alias Prolegals.Emails.Email
    alias Prolegals.Emails.Email, as: Alert



    def list_log_book_users(conn, params) do

      list_log_book_users = Security.list_sec_tbl_log_book(params)
      render(conn, "list_log_book_users.html", list_log_book_users: list_log_book_users)
    end

    def history_log_book_users(conn, params) do
      history_log_book_users = Security.list_sec_tbl_log_book(params)
      render(conn, "history_log_book_users.html", history_log_book_users: history_log_book_users)
    end

   def create_log_book_user(conn, params) do

      time = Time.to_string(Timex.now)
      date = Date.to_string(Timex.today)
      param = Map.merge(params, %{
          "time_in" => time,
          "date" =>  date
        })

    case Security.create_log_book(param) do
        {:ok, _} ->
          conn
          |> put_flash(:info, "New Visitor Added To System")
          |> redirect(to: Routes.user_path(conn, :dashboard))

          conn

        {:error, _} ->
          conn
          |> put_flash(:error, "Failed To Add Visitor User To system.")
          |> redirect(to: Routes.user_path(conn, :dashboard))
    end
   end

   def add_time_out(conn, %{"id" => id} = params) do
    list_log_book_user = Security.get_log_book!(id)

      time = Time.to_string(Timex.now)
      param = Map.merge(params, %{
          "time_out" => time
        })

      Ecto.Multi.new()
      |> Ecto.Multi.update(:list_log_book_user, LogBook.changeset(list_log_book_user, param))
      |> Ecto.Multi.run(:userlogs, fn %{list_log_book_user: list_log_book_user} ->
        activity = "Prolegals Check Out updated with ID \"#{list_log_book_user.id}\""

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
          |> put_flash(:info, "Check Out successfully updated:-) ")
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))
      end
   end

   def edit_log_book_user(conn, %{"id" => id} = params) do
    list_log_book_user = Security.get_log_book!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:list_log_book_user, LogBook.changeset(list_log_book_user, params))
      |> Ecto.Multi.run(:userlogs, fn %{list_log_book_user: list_log_book_user} ->
        activity = "Prolegals LogBook updated with ID \"#{list_log_book_user.id}\""

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
          |> put_flash(:info, "LogBook successfully updated:-) ")
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))
      end
   end

   def view_log_book_user(conn, %{"id" => id}) do
    logbook_users = Security.get_log_book!(id)
    render(conn, "view_log_book_user.html", logbook_users: logbook_users )
   end

   def check_in_log_book_user(conn, params) do

    case Security.create_log_book(params) do
        {:ok, _} ->
          conn
          |> put_flash(:info, "New Visitor Added To System")
          |> redirect(to: Routes.security_path(conn, :history_log_book_users))

          conn

        {:error, _} ->
          conn
          |> put_flash(:error, "Failed To Add New Visitor To system.")
          |> redirect(to: Routes.security_path(conn, :history_log_book_users))
    end
   end

  def sec_reports(conn, params) do
    sec_reports = Security.list_sec_tbl_log_book(params)
    render(conn, "security_report.html", sec_reports: sec_reports)
  end


  def alert_not_checked_out() do
    recipient = "coolsniper180@gmail.com"
    items = Security.not_check_out()

    if items != [] do
      Alert.send_check_out_alert(items, recipient)
    else
      IO.puts("Every one has Checked Out")
    end


  end

   def traverse_errors(errors) do
    for {key, {msg, _opts}} <- errors, do: "#{key} #{msg}"
   end


end
