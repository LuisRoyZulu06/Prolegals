defmodule ProlegalsWeb.ClientController do
  use ProlegalsWeb, :controller

  alias Prolegals.Client.Messages
  alias Prolegals.Client
  alias Prolegals.{Logs, Repo, Logs.UserLogs, Auth}
  alias Prolegals.Accounts
  alias Prolegals.Accounts.User

    def list_messages(conn, _params) do
      msg = Client.get_send_message()
      msgs = Client.list_cl_tbl_messages()
      render(conn, "messages.html", msgs: msgs, msg: msg)
    end

    def create_message(conn, params) do
      case Client.create_messages(params) do
          {:ok, _params} ->
            conn
            |> put_flash(:info, "Message submitted successfully.")
            |> redirect(to: Routes.client_path(conn, :list_messages))

            conn
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
