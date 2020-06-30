defmodule ProlegalsWeb.ClientController do
  use ProlegalsWeb, :controller

  import Ecto.Query, warn: false
  alias Prolegals.Client.Messages
  alias Prolegals.Client
  alias Prolegals.{Logs, Repo, Logs.UserLogs, Auth}
  alias Prolegals.Accounts
  alias Prolegals.Accounts.User
  # alias Prolegals.Emails.Email, as: Alert
  alias Prolegals.Emails.Email
  # alias Prolegals.Emails.Mailer
  alias Prolegals.Notifications

    def list_messages(conn, _params) do
      msg = Client.get_send_message()
      msgs = Client.list_cl_tbl_messages()
      render(conn, "messages.html", msgs: msgs, msg: msg)
    end

    # defp send_notification do
    #   Email.send_alert() |> Mailer.deliver()
    # end

    # defp send_message_params(params) do
    #   map = params
    #   IO.inspect "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    #   IO.inspect map

    #   map["recipient"]

    #   Email.send_alert(map["recipient"]) |> Mailer.deliver_later()

    # end
    def send_emails do

      Email.send_alert("coilardium@gmail.com", " helooooooo")
    end

    def create_message(conn, params) do
      IO.inspect  "********************Start**************************"
      IO.inspect params

      case Client.create_messages(params) do

          {:ok, params} ->
            Email.send_alert(params.recipient, params.messages)
            conn

            |> put_flash(:info, "Message submitted successfully.")
            |> redirect(to: Routes.client_path(conn, :list_messages))
            # |> send_message_params()
            # |> Task.async_stream(&Alert.send_alert(&1.email, params), max_concurrency: 30, timeout: 30_000)
            # |> Stream.run
            # {:ok, :sent}

          {:error, _params} ->
            conn
            |> put_flash(:error, "Failed to submit message.")
            |> redirect(to: Routes.client_path(conn, :list_messages))
        end
    end


    def traverse_errors(errors) do
      for {key, {msg, _opts}} <- errors, do: "#{key} #{msg}"
    end


end
