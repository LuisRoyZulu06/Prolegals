defmodule ProlegalsWeb.LegalController do
  use ProlegalsWeb, :controller

  def contacts(conn, _params) do
    render(conn, "contacts.html")
  end
end
