defmodule ProlegalsWeb.LegalController do
  use ProlegalsWeb, :controller

alias Prolegals.Litigation
alias Prolegals.Litigation.Cases
alias Prolegals.Litigation.Events
alias Prolegals.Litigation.Contacts

	def contacts(conn, _params) do
	  	contacts = Litigation.list_li_tbl_contacts()
	  	render(conn, "contacts.html", contacts: contacts)
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

	def case_mgt(conn, _params) do
		cases = Litigation.list_li_tbl_case()
		render(conn, "case_mgt.html", cases: cases)
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

	def notifications(conn, _params) do
		render(conn, "notifications.html")
	end

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
end
