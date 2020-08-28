defmodule ProlegalsWeb.ClientController do
  use ProlegalsWeb, :controller

  import Ecto.Query, warn: false
  alias Prolegals.Client
  alias Prolegals.Emails.Email
  alias Prolegals.SystemDirectories.Directory
  alias Prolegals.Client.Documents
  alias Prolegals.{Repo, Logs.UserLogs}
  alias Prolegals.Accounts
  alias Prolegals.Client.Messages
  

  
  plug(ProlegalsWeb.Plugs.RequireAuth when action in [
    :list_messages,
    :create_message,
    :traverse_errors

  ])
 

    def list_messages(conn, _params) do
      email = Accounts.get_user!(conn.assigns.user.id).email
      msgs = Client.get_inbox_notification(email)
      render(conn, "messages.html", msgs: msgs )
    end

 
    def create_message(conn, params) do

      case Client.create_messages(params) do

          {:ok, params} ->
            Email.send_alert(params.recipient, params.messages, params.subject )
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

    def list_document(conn, _params) do
      documents = Client.list_cl_tbl_documents()
      render(conn, "document.html", documents: documents)
    end


    def trash(conn, _) do
      email = Accounts.get_user!(conn.assigns.user.id).email
      trashs = Client.get_client_trash_notification(email)
      render(conn, "trash.html", trashs: trashs )
    end

    def update_trash(conn, %{"id" => id} = params) do
      trashs = Client.get_messages!(id)
      Ecto.Multi.new()
      |> Ecto.Multi.update(:trashs , Messages.changeset(trashs , params))
      |> Ecto.Multi.run(:user_log, fn %{trashs: _trashs } ->
        activity = "Conversion Moved to trash having id #{trashs.id}"
  
        user_log = %{
            user_id: conn.assigns.user.id,
            activity: activity
        }
  
        UserLogs.changeset(%UserLogs{}, user_log)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{trashs: _trashs, user_log: _user_log}} ->
          conn
          |> put_flash(:info, "Conversion Moved to trash.")
          |> redirect(to: Routes.client_path(conn, :list_messages))
  
        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()
  
          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.client_path(conn, :list_messages, id: id))
      end
    rescue
      _ ->
        conn
        |> put_flash(:error, "An error occurred, reason unknown. try again")
        |> redirect(to: Routes.client_path(conn, :list_messages))
    end

    def trash_to_inbox(conn, %{"id" => id} = params) do
      trashs = Client.get_messages!(id)
      Ecto.Multi.new()
      |> Ecto.Multi.update(:trashs , Messages.changeset(trashs , params))
      |> Ecto.Multi.run(:user_log, fn %{trashs: _trashs } ->
        activity = "Conversion Moved to inbox having id #{trashs.id}"
  
        user_log = %{
            user_id: conn.assigns.user.id,
            activity: activity
        }
  
        UserLogs.changeset(%UserLogs{}, user_log)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{trashs: _trashs, user_log: _user_log}} ->
          conn
          |> put_flash(:info, "Conversion Moved to Inbox.")
          |> redirect(to: Routes.client_path(conn, :trash))
  
        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()
  
          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.client_path(conn, :trash, id: id))
      end
    # rescue
    #   _ ->
    #     conn
    #     |> put_flash(:error, "An error occurred, reason unknown. try again")
    #     |> redirect(to: Routes.client_path(conn, :trash))
    end

    
    
    def sent_message(conn, _) do
      email = Accounts.get_user!(conn.assigns.user.id).email
      msgs = Client.get_client_sent_notification(email)
      render(conn, "sent_message.html", msgs: msgs )
    end

   
    # ----------------------------------------------------- Document Upload

    def document_upload(conn, params) do
      user = conn.assigns.user
      
      {key, msg, _invalid} = handle_file_upload(user, params)
    
      if key == :info do
        conn
        |> put_flash(key, msg)
        |> redirect(to: Routes.client_path(conn, :list_document))
  
      else
        conn
        |> put_flash(key, msg)
        |> redirect(to: Routes.client_path(conn, :list_document))
      end
    end
  
  
    defp handle_file_upload(user, params) do
    
      with {:ok, filename, destin_path, _rows} <- is_valide_file(params) do
        user
        |> process_bulk_upload(filename, destin_path)
        |> case do
          {:ok, {invalid, valid}} ->
            {:info, "#{valid} Successful entrie(s) and #{invalid} invalid entrie(s)", invalid}
  
          {:error, reason} ->
            {:error, reason, 0}
        end
      else
        {:error, reason} ->
          {:error, reason, 0}
      end
    end
  
  
    def process_csv(file) do
      case File.exists?(file) do
        true ->
          data =
            File.stream!(file)
            |> CSV.decode!(separator: ?,, headers: true)
            |> Enum.map(& &1)
  
          {:ok, data}
  
        false ->
          {:error, "File does not exist"}
      end
    end
  
    def process_bulk_upload(user, filename, path) do
      # try do
        {:ok, items} = extract_xlsx(path)
  
        prepare_bulk_params(user, filename, items)
        |> Repo.transaction(timeout: 290_000)
        |> case do
          {:ok, multi_records} ->
            {invalid, valid} =
              multi_records
              |> Map.values()
              |> Enum.reduce({0, 0}, fn item, {invalid, valid} ->
                case item do
                  %{document_filename: _src} -> {invalid, valid + 1}
                  %{col_index: _index} -> {invalid + 1, valid}
                  _ -> {invalid, valid}
                end
              end)
  
            {:ok, {invalid, valid}}
  
          {:error, _, changeset, _} ->
            # prepare_error_log(changeset, filename)
            reason = traverse_errors(changeset.errors) |> Enum.join("\r\n")
            {:error, reason}
        end
      # after
      #   filename = Path.rootname(filename) |> Path.basename()
      # end
    end
  
    defp prepare_bulk_params(user, filename, items) do
   
      items
      |> Stream.with_index(2)
      |> Stream.map(fn {item, index} ->
        changeset =
          %Documents{document_filename: filename} 
          |> Documents.changeset(Map.put(item, :user_id, user.id))
  
        Ecto.Multi.insert(Ecto.Multi.new(), Integer.to_string(index), changeset)
  
      end)
  
      # |> filter_upload_errors(filename)
      |> Enum.reject(fn
        %{operations: [{_, {:run, _}}]} -> false
        %{operations: [{_, {_, changeset, _}}]} -> changeset.valid? == false
      end)
      |> Enum.reduce(Ecto.Multi.new(), &Ecto.Multi.append/2)
    end
  
    # ---------------------- file persistence --------------------------------------
    def is_valide_file(%{"document_filename" => params}) do
        if upload = params do
          case Path.extname(upload.filename) do
            ext when ext in ~w(.xlsx .XLSX .xls .XLS .csv .CSV .pdf .PDF .doc .DOC .docx .DOCX) ->
              with {:ok, destin_path} <- persist(upload) do
                case ext not in ~w(.csv .CSV .pdf .PDF .doc .DOC .docx .DOCX) do
                  true ->
                    case Xlsxir.multi_extract(destin_path, 0, false, extract_to: :memory) do
                      {:ok, table_id} ->
                        row_count = Xlsxir.get_info(table_id, :rows)
                        Xlsxir.close(table_id)
                        {:ok, upload.filename, destin_path, row_count - 1}
    
                      {:error, reason} ->
                        {:error, reason}
                    end
    
                  _ ->
                    {:ok, upload.filename, destin_path, "N(count)"}
                end
              else
                {:error, reason} ->
                  {:error, reason}
              end
    
            _ ->
              {:error, "Invalid File Format"}
          end
        else
          {:error, "No File Uploaded"}
        end
      end
  
    def csv(path, upload) do
      case process_csv(path) do
        {:ok, data} ->
          row_count = Enum.count(data)
          IO.inspect("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
          IO.inspect(row_count)
  
          case row_count do
            rows when rows in 1..100_000 ->
              {:ok, upload.filename, path, row_count}
  
            _ ->
              {:error, "File records should be between 1 to 100,000"}
          end
  
        {:error, reason} ->
          IO.inspect(reason)
  
          {:error, reason}
      end
    end
  
  
      def persist(%Plug.Upload{filename: filename, path: path}) do
        dir_path = Repo.one(Directory)
  
        destin_path = (dir_path && dir_path.processed)  || "C:/Document/file" |> default_dir()
        destin_path = Path.join(destin_path, filename)
  
          {_key, _resp} =
          with true <- File.exists?(destin_path) do
            {:error, "File with the same name aready exists"}
          else
            false ->
              File.cp(path, destin_path)
              {:ok, destin_path}
          end
      end
      
  
      def default_dir(path) do
        File.mkdir_p(path)
        path
      end
  
  
    def extract_xlsx(path) do
      case Xlsxir.multi_extract(path, 0, false, extract_to: :memory) do
        {:ok, id} ->
          items =
            Xlsxir.get_list(id)
            |> Enum.reject(&Enum.empty?/1)
            |> Enum.reject(&Enum.all?(&1, fn item -> is_nil(item) 
          end))
            |> List.delete_at(0)
            |> Enum.map(
              &Enum.zip(
                Enum.map(@headers, fn h -> h end),
                Enum.map(&1, fn v -> strgfy_term(v) end)
              )
            )
            |> Enum.map(&Enum.into(&1, %{}))
            |> Enum.uniq_by(&String.trim(&1.mobile))
            |> Enum.reject(&(Enum.join(Map.values(&1)) == ""))
  
          Xlsxir.close(id)
          {:ok, items}
  
  
        {:error, reason} ->
          {:error, reason}
      end
    end
  
      defp strgfy_term(term) when is_tuple(term), do: term
      defp strgfy_term(term) when not is_tuple(term), do: String.trim("#{term}")

    # ------------------------------------------------------------------------


    def traverse_errors(errors) do
      for {key, {msg, _opts}} <- errors, do: "#{key} #{msg}"
    end


end
