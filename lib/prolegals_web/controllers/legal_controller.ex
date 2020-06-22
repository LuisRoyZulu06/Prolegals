defmodule ProlegalsWeb.LegalController do
  use ProlegalsWeb, :controller

alias Prolegals.Litigation
alias Prolegals.Litigation.Cases
alias Prolegals.Litigation.Events
alias Prolegals.Litigation.Contacts
alias Prolegals.Litigation.BusinessCategory

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

	def case_mgt(conn, _params) do
		cases = Litigation.list_li_tbl_case()
		case_type = Litigation.list_li_tbl_case_types()
		contacts = Litigation.list_li_tbl_contacts()
		render(conn, "case_mgt.html", cases: cases, case_type: case_type)
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
end
