defmodule ProlegalsWeb.NotificationController do
  use ProlegalsWeb, :controller
  alias Prolegals.Notifications
  alias Prolegals.{Logs.User_log, Repo}
  alias Prolegals.Notifications.Email
  alias ProlegalsWeb.UserController



  plug(
    ProlegalsWeb.Plugs.RequireAuth
    when action in [:index, :edit_email, :create_email, :update_email, :delete_email]
  )

  plug(
    ProlegalsWeb.Plugs.RequireAdminAccess
    when action not in [:dashboard]
  )

  def index(conn, _params) do
    emails = Notifications.emails()
    render(conn, "index.html", emails: emails)
  end

  def edit_email(conn, %{"id" => id}) do
    email = Notifications.get_email!(id)
    render(conn, "edit_email.html", email: email)
  end

  def create_email(conn, params) do
    user = conn.assigns.user
    params = Map.merge(%{"maker_id" => user.id}, params)
    Ecto.Multi.new()
    |> Ecto.Multi.insert(:email, Email.changeset(%Email{}, params))
    |> Ecto.Multi.run(:user_log, fn %{email: email} ->
      activity = "Created new email: \"#{email.email}\" and type: \"#{email.type}\""
      # User_log.changeset(%User_log{}, %{
      #   user_id: user.id,
      #   activity: activity
      # })
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{email: _email, user_log: _user_log}} ->
        conn
        |> put_flash(:info, "email Created successfully.")
        |> redirect(to: Routes.notification_path(conn, :index))

      {:error, _failed_operation, failed_value, _changes_so_far} ->
        reason = UserController.traverse_errors(failed_value.errors) |> List.first()

        conn
        |> put_flash(:error, reason)
        |> redirect(to: Routes.notification_path(conn, :index))
    end
  end

  def update_email(conn, %{"id" => id} = params) do
    email = Notifications.get_email!(id)

    user_id = conn.assigns.user.id
    params = Map.merge(%{"user_id" => user_id}, params)
    Ecto.Multi.new()
    |> Ecto.Multi.update(:email, Email.changeset(email, params))
    |> Ecto.Multi.run(:user_log, fn %{email: email} ->
        activity = "Updated email \"#{email.type}\""

        # user_log = %{
        #   user_id: conn.assigns.user.id,
        #   activity: activity
        # }

        # User_log.changeset(%User_log{}, user_log)
        |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{email: _email, user_log: _user_log}} ->
        conn
        |> put_flash(:info, "email updated successfully")
        |> redirect(to: Routes.notification_path(conn, :edit_email, id: id))

      {:error, _failed_operation, failed_value, _changes_so_far} ->
        reason = UserController.traverse_errors(failed_value.errors) |> List.first()

        conn
        |> put_flash(:error, reason)
        |> redirect(to: Routes.notification_path(conn, :edit_email, id: id))
    end
  end

  def delete_email(conn, %{"id" => id}) do
    email = Notifications.get_email!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.delete(:email, email)
    |> Ecto.Multi.run(:user_log, fn %{email: email} ->
      activity = "Deleted email with address \"#{email.email}\""
      # User_log.changeset(%User_log{}, %{
      #   user_id: conn.assigns.user.id,
      #   activity: activity
      # })
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{email: _email, user_log: _user_log}} ->
        json(conn, %{info: "Email deleted successfully."})

      {:error, _failed_operation, failed_value, _changes_so_far} ->
        reason = UserController.traverse_errors(failed_value.errors) |> Enum.join("\r\n")
        json(conn, %{error: reason})
    end
  end

end
