defmodule ProlegalsWeb.LegalController do
  use ProlegalsWeb, :controller

alias Prolegals.Repo
alias Prolegals.Accounts
alias Prolegals.Litigation
alias Prolegals.Accounts.User
alias Prolegals.Litigation.Cases
alias Prolegals.Litigation.Events
alias Prolegals.Litigation.Contacts
alias Prolegals.Litigation.Evidence
alias Prolegals.Litigation.BusinessCategory
alias Prolegals.SystemDirectories.Directory
alias Prolegals.{Logs, Repo, Logs.UserLogs, Auth}

@headers ~w/sn name email phone company_name job_title id_type id_no bus_category contact_type tel city country address client_portal status/a
# @data_dir Path.join([__DIR__, "../../../", "priv/static/uploads"])

# ---------------------------------- Contact Mgt
	def contacts(conn, _params) do
	  	contacts = Litigation.list_li_tbl_contacts()
	  	business_type = Litigation.list_li_tbl_business_categories()
	  	render(conn, "contacts.html", contacts: contacts, business_type: business_type)
	end

	def create_contact(conn, params) do
	  	case Litigation.create_contacts(params) do
			{:ok, _} ->
				conn
				|> put_flash(:info, "Contact created.")
				|> redirect(to: Routes.legal_path(conn, :contacts))

				conn

			{:error, _} ->
				conn
				|> put_flash(:error, "Failed create contact.")
				|> redirect(to: Routes.legal_path(conn, :contacts))
	  	end
	end

	def update_contact(conn, %{"id" => id} = params) do
		contact = Litigation.get_contacts!(id)
		case Litigation.update_contacts(contact, params)do
			{:ok, _} ->
				conn
				|> put_flash(:info, "Contact updated.")
				|> redirect(to: Routes.legal_path(conn, :contacts))

				conn

			{:error, _} ->
				conn
				|> put_flash(:error, "Contact update failed.")
				|> redirect(to: Routes.legal_path(conn, :contacts))
		end
	end

	def delete_contact(conn, %{"id" => id}) do
		contact = Litigation.get_contacts!(id)
		case Litigation.update_contacts(contact, %{status: "deleted"})do
			{:ok, _} ->
				conn
				|> json(%{"data" => "Contact successfully deleted"})

			{:error, error} ->
				conn
				|> json(%{"error" => "Failed to delete contact"})
		end
	end

	def contacts_trash(conn, _params)do
		contacts = Litigation.list_li_tbl_contacts()
		render(conn, "contacts_trash.html", contacts: contacts)
	end

	def restore(conn, %{"id" => id}) do
		contact = Litigation.get_contacts!(id)
		case Litigation.update_contacts(contact, %{status: "active"})do
			{:ok, _} ->
				conn
				|> json(%{"data" => "Contact successfully restored"})

			{:error, error} ->
				conn
				|> json(%{"error" => "Failed to restore contact"})
		end
	end

	def delete_forever(conn, %{"id" => id}) do
	    contact = Litigation.get_contacts!(id)

	    Ecto.Multi.new()
	    |> Ecto.Multi.delete(:contact, contact)
	    |> Ecto.Multi.run(:userlogs, fn %{contact: contact} ->
	      activity = "Contact Deleted \"#{contact.id}\""

	      userlogs = %{
	        user_id: conn.assigns.user.id,
	        activity: activity
	      }

	      UserLogs.changeset(%UserLogs{}, userlogs)
	      |> Repo.insert()
	    end)
	    |> Repo.transaction()
	    |> case do
	      {:ok, %{contact: contact, userlogs: userlogs}} ->
	        conn
	        |> put_flash(:info, "Contact Deleted.")
	        |> redirect(to: Routes.legal_path(conn, :contacts_trash))

	      # {:error, failed_operation, failed_value, changes_so_far} ->
	      #  reason = AdminController._traverse_errors(failed_value.errors) |> List.first()

	      #  conn
	      #  |> put_flash(:error, reason)
	      #  |> redirect(to: Routes.admin_path(conn, :inventory))
	    end
  	end



# ---------------------------------- Case Mgt
	def case_mgt(conn, _params) do
		users = Accounts.list_tbl_users()
		cases = Litigation.list_li_tbl_case()
		contacts = Litigation.list_li_tbl_contacts()
		case_type = Litigation.list_li_tbl_case_types()
		render(conn, "case_mgt.html", cases: cases, case_type: case_type, contacts: contacts, users: users)
	end

	def create_case(conn, params) do
	  	case Litigation.create_cases(params) do
	        {:ok, _} ->
	        	conn
	        	|> put_flash(:info, "New case added.")
	        	|> redirect(to: Routes.legal_path(conn, :case_mgt))

	            conn

	        {:error, _} ->
	        	conn
	        	|> put_flash(:error, "Failed to create case.")
	        	|> redirect(to: Routes.legal_path(conn, :case_mgt))
	  	end
	end

	def case_update(conn, _params) do
		cases = Litigation.list_li_tbl_case()
		evidence = Litigation.list_li_tbl_evidence()
		render(conn, "case_update.html", cases: cases, evidence: evidence)
	end

	def evidence_update(conn, params) do
		case Litigation.create_evidence(params) do
	        {:ok, _} ->
	        	conn
	        	|> put_flash(:info, "New evidence added.")
	        	|> redirect(to: Routes.legal_path(conn, :case_update))

	            conn

	        {:error, _} ->
	        	conn

	        	|> put_flash(:error, "Failed to add evidence.")
	        	|> redirect(to: Routes.legal_path(conn, :case_update))
	  	end
	end

	def edit_case(conn, %{"id" => id} = params) do
		update_case_details = Litigation.get_cases!(id)
		case Litigation.update_cases(update_case_details, params)do
			{:ok, _} ->
				conn
				|> put_flash(:info, "Case details updated.")
				|> redirect(to: Routes.legal_path(conn, :case_mgt))

				conn

			{:error, _} ->
				conn
				|> put_flash(:error, "Failed to update case details.")
				|> redirect(to: Routes.legal_path(conn, :case_mgt))
		end
	end

	def notifications(conn, _params) do
		render(conn, "notifications.html")
	end

# ---------------------------------- Task Mgt
	def tasks(conn, _params) do
		tasks = Litigation.list_li_tbl_tasks()
		render(conn, "tasks.html", tasks: tasks)
	end

	def create_task(conn, params) do
	  	case Litigation.create_events(params) do
	          {:ok, _} ->
	            conn
	            |> put_flash(:info, "Event created.")
	            |> redirect(to: Routes.legal_path(conn, :tasks))

	            conn

	          {:error, _} ->
	            conn
	            |> put_flash(:error, "Failed to create event.")
	            |> redirect(to: Routes.legal_path(conn, :tasks))
	  	end
	end

	def practice_area(conn, params) do
		case_type = Litigation.list_li_tbl_case_types()
		render(conn, "practice_area.html", case_type: case_type)
	end

	def create_case_type(conn, params) do
		case Litigation.create_case_type(params) do
	          {:ok, _} ->
	            conn
	            |> put_flash(:info, "Case category entered.")
	            |> redirect(to: Routes.legal_path(conn, :practice_area))

	            conn

	          {:error, _} ->
	            conn
	            |> put_flash(:error, "Failed to create case category.")
	            |> redirect(to: Routes.legal_path(conn, :practice_area))
	  	end
	end

	def update_case_type(conn, %{"id" => id} = params) do
		bus_type = Litigation.get_case_type!(id)
		case Litigation.update_case_type(bus_type, params)do
			{:ok, _} ->
				conn
				|> put_flash(:info, "Case type updated.")
				|> redirect(to: Routes.legal_path(conn, :practice_area))

				conn

			{:error, _} ->
				conn
				|> put_flash(:error, "Failed to update case type.")
				|> redirect(to: Routes.legal_path(conn, :practice_area))
		end
	end

	def bus_category(conn, params) do
		business_type = Litigation.list_li_tbl_business_categories()
		render(conn, "bus_category.html", business_type: business_type)
	end

	def create_business_type(conn, params) do
		case Litigation.create_business_category(params) do
	          {:ok, _} ->
	            conn
	            |> put_flash(:info, "Successfully created new business type.")
	            |> redirect(to: Routes.legal_path(conn, :bus_category))

	            conn

	          {:error, _} ->
	            conn
	            |> put_flash(:error, "Failed to create new business type.")
	            |> redirect(to: Routes.legal_path(conn, :bus_category))
	  	end
	end

	def update_business_type(conn, %{"id" => id} = params) do
		bus_type = Litigation.get_business_category!(id)
		case Litigation.update_business_category(bus_type, params)do
			{:ok, _} ->
				conn
				|> put_flash(:info, "Business category updated.")
				|> redirect(to: Routes.legal_path(conn, :bus_category))

				conn

			{:error, _} ->
				conn
				|> put_flash(:error, "Failed to update business category.")
				|> redirect(to: Routes.legal_path(conn, :bus_category))
		end
	end

# ---------------------------------- File upload
	def create_bulk_contact(conn, params) do
	    {key, msg} = handle_contacts(params)
	    conn
	    |> put_flash(key, msg)
	    |> redirect(to: Routes.legal_path(conn, :contacts))

	    # rescue
	    #   _ ->
	    #     conn
	    #     |> put_flash(:error, "Something went wrong. try again")
	    #     |> redirect(to: Routes.message_path(conn, :broadcast_sms))
	end

	defp handle_contacts(params) do
	# user,
	with {:ok, filename, destin_path, rows} <- is_file_valid(params) do
  	enque_upload(filename, destin_path)
  		# user,
  		{:info, "#{rows} contacts added."}
	else
  		{:error, reason} ->
    	{:error, reason}
	end
	end

	defp enque_upload(filename, destin_path) do
		# user,
	{:ok, _pid} =
		Task.Supervisor.start_child(
	Prolegals.TaskSupervisor,
	fn ->
  	process_bulk_upload(filename, destin_path)
  	# user,
	end
		)
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

  	def process_bulk_upload(filename, path) do
    	# user,
    	{:ok, items} = extract_xlsx(path)

    	prepare_bulk_params(filename, items)
    	|> Repo.transaction(timeout: 220_000)
    	|> case do
      	{:ok, _multi_records} ->
        	{:ok, "bulk processing complete!!!"}

      	{:error, _failed_operation, failed_value, _changes_so_far} ->
        	IO.inspect failed_value
        	# reason = UserController.traverse_errors(changeset.errors) |> List.first()
        	{:error}
        	# , reason
    	end
  	end




  	defp prepare_bulk_params(_filename, items) do
			items
			|> Stream.with_index()
			|> Stream.map(fn {item, index} ->
				changeset = Contacts.changeset(%Contacts{},item)

				Ecto.Multi.insert(Ecto.Multi.new(), Integer.to_string(index), changeset)

      # |> Ecto.Multi.run("user_log_#{index}", fn _changes ->
      #   activity =
      #     "Created transaction with src acc \"#{item.src_acc_no}\" and destination \"#{
      #       item.destin_acc_no
      #     }\""


      #   # user_log = %{
      #   #   user_id: user_id,
      #   #   activity: activity
      #   # }

      #   # Activity.changeset(%Activity{}, user_log)
      #   |> Repo.insert()
      # end)
    	end)
    	|> Enum.reject(fn %{operations: [{_, {_,changeset, _}}]} -> changeset.valid? == false end)
    	|> Enum.reduce(Ecto.Multi.new(), &Ecto.Multi.append/2)
  	end

  	# defp prepare_bulk_params(filename, items) do
   #  	items
   #  	|> Stream.with_index()
   #  	|> Stream.map(fn {item, index} ->
   #  		# %Contacts.changeset{contact_bulk_filename: filename}
   #    	changeset = Contacts.changeset{%Contacts{}, filename}
   #      |> Contacts.changeset(item)

   #    	Ecto.Multi.insert(Ecto.Multi.new(), Integer.to_string(index), changeset)
   #    # |> Ecto.Multi.run("user_log_#{index}", fn _changes ->
   #    #   activity =
   #    #     "Created transaction with src acc \"#{item.src_acc_no}\" and destination \"#{
   #    #       item.destin_acc_no
   #    #     }\""


   #    #   # user_log = %{
   #    #   #   user_id: user_id,
   #    #   #   activity: activity
   #    #   # }

   #    #   # Activity.changeset(%Activity{}, user_log)
   #    #   |> Repo.insert()
   #    # end)
   #  	end)
   #  	|> Enum.reject(fn %{operations: [{_, {_, changeset, _}}]} -> changeset.valid? == false end)
   #  	|> Enum.reduce(Ecto.Multi.new(), &Ecto.Multi.append/2)
  	# end



	def is_file_valid(%{"contact_bulk_filename" => params}) do
      if upload = params do
        case Path.extname(upload.filename) do
          ext when ext in ~w(.csv .CSV .xlsx .XLSX .xls .XLS) ->

            with destin_path <- persist(upload) do
              case ext do
                ".csv" -> csv(destin_path, upload)
                ".xlsx" -> excel(destin_path, upload)
                ".xls" -> excel(destin_path, upload)
              end
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

          case row_count do
            rows when rows in 1..100_000 ->
              {:ok, upload.filename, path, row_count}
            _ ->
              {:error, "File records should be between 1 to 100,000"}
          end

        {:error, reason} ->
          {:error, reason}
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

    def excel(path, upload) do
    	IO.inspect path
      case Xlsxir.multi_extract(path, 0, false, extract_to: :memory) do
        {:ok, table_id} ->
          row_count = Xlsxir.get_info(table_id, :rows)
          Xlsxir.close(table_id)

          case row_count do
            rows when rows in 1..100_000 ->
              {:ok, upload.filename, path, row_count}

            _ ->
              {:error, "File records should be between 1 to 100,000"}
          end

        {:error, reason} ->
        	IO.inspect "====================="
        	IO.inspect reason

          {:error, reason}
      end
    end

    def persist(%Plug.Upload{filename: filename, path: path}) do
  		dir_path = Repo.one(Directory)
  		destin_path = (dir_path && dir_path.processed) || "C:/Xampp/htdocs/work/elixir/probase/prolegals/uploads" |> default_dir()
  		# destin_path = Path.join(destin_path, filename)

      	destin_path =
        with true <- File.exists?(Path.join(destin_path, filename)) do
          extname = Path.extname(filename)

          file =
            filename
            |> Path.basename(Path.extname(filename))

          filename = "#{file}_#{:os.system_time(:seconds)}#{extname}"
          Path.join(destin_path, filename)
        else
          false ->
             Path.join(destin_path, filename)
        end
      File.cp(path, destin_path)
      destin_path
    end

  	def default_dir(path) do
  		File.mkdir_p(path)
  		path
  	end

    def extract_xlsx(path) do
	    case Xlsxir.multi_extract(path, 0, false, extract_to: :memory) do
	      {:ok, table_id} ->
	        items =
	          Xlsxir.get_list(table_id)
	          |> Enum.uniq()
	          |> Enum.reject(&Enum.empty?/1)
	          |> Enum.reject(&Enum.all?(&1, fn item -> is_nil(item) end))
	          |> List.delete_at(0)
	          |> Enum.map(
	            &Enum.zip(
	              Enum.map(@headers, fn h -> h end),
	              Enum.map(&1, fn v -> strgfy_term(v) end)
	            )
	          )
	          |> Enum.map(&Enum.into(&1, %{}))
	          |> Enum.uniq_by(&String.trim(&1.id_no))
	          |> Enum.reject(&(Enum.join(Map.values(&1)) == ""))

	        Xlsxir.close(table_id)
	        {:ok, items}

	      {:error, reason} ->
	        {:error, reason}
	    end
  	end

    defp strgfy_term(term) when is_tuple(term), do: term
    defp strgfy_term(term) when not is_tuple(term), do: String.trim("#{term}")
# -------------------------------------------------------------------------------
end
