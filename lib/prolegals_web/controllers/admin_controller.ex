defmodule ProlegalsWeb.AdminController do
  use ProlegalsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def ammunition(conn, _params) do
    render(conn, "ammunition.html")
  end

  def firearm(conn, _params) do
    render(conn, "firearm.html")
  end

end
