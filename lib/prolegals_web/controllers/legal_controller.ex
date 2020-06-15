defmodule ProlegalsWeb.LegalController do
  use ProlegalsWeb, :controller

alias Prolegals.Litigation
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
end
