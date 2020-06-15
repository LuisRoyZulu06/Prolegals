defmodule ProlegalsWeb.SecurityController do
    use ProlegalsWeb, :controller

    alias Prolegals.Securitys.Log_book
    alias Prolegals.Securitys
    alias Prolegals.Accounts
    alias Prolegals.Accounts.User
  
    def list_log_book_users(conn, _params) do
      list_log_book_users = Securitys.list_tbl_log_book() 
      render(conn, "list_log_book_users.html", list_log_book_users: list_log_book_users)
    end

    def create_log_book_user(conn, params) do
      IO.inspect "###################################### start s#####"
      IO.inspect params
      case Securitys.create_log_book(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "New User Added To System")
            |> redirect(to: Routes.user_path(conn, :dashboard))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add New User To system.")
            |> redirect(to: Routes.user_path(conn, :dashboard))
      end
  end 

   def add_time_out(conn, params) do
      case Securitys.create_log_book(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "User Time Out Added To System")
            |> redirect(to: Routes.security_path(conn, :list_log_book_users))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add User Time Out To system.")
            |> redirect(to: Routes.security_path(conn, :list_log_book_users))
      end
   end 



    
end
  