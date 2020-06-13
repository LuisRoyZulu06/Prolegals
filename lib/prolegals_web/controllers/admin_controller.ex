defmodule ProlegalsWeb.AdminController do
  use ProlegalsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
