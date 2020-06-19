defmodule ProlegalsWeb.LegalController do
  use ProlegalsWeb, :controller

alias Prolegals.Litigation
alias Prolegals.Litigation.Contacts
alias Prolegals.Litigation.Cases

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
		render(conn, "tasks.html")
	end
end
