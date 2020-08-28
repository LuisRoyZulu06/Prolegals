defmodule ProlegalsWeb.SecurityController do
    use ProlegalsWeb, :controller
    import Ecto.Query

    alias Prolegals.Security
    alias Prolegals.Security.LogBook
    alias Prolegals.{Repo, Logs.UserLogs}
    alias Prolegals.Emails.Email, as: Alert
    alias Prolegals.SystemDirectories.Directory
    alias ProlegalsWeb.LegalController
    alias Prolegals.Repo

    plug(ProlegalsWeb.Plugs.RequireAuth when action in [
      :csv_exp,
      :list_log_book_users,
      :history_log_book_users,
      :create_log_book_user,
      :save_image,
      :add_time_out,
      :edit_log_book_user,
      :view_log_book_user,
      :recheck_in_visitor,
      :alert_not_checked_out,
      :system_checkout,
      :recheck_in,
      :traverse_errors,
      :sec_reports,
      :view_report_details,
      :item_lookup,
      :confirm_report_type,
      :total_entries,
      :entries,
      :search_options,
      :calculate_page_num,
      :calculate_page_size,
      :csv_exp,
      :process_report,
      :report_generator

       ])

    # @img_dir Path.join([__DIR__, "../../../", "uploads/Sec_facial_image/"])
    
     
    def list_log_book_users(conn, params) do
      list_log_book_users = Security.list_sec_tbl_log_book(params)
      render(conn, "list_log_book_users.html", list_log_book_users: list_log_book_users)
    end

    def history_log_book_users(conn, params) do
      history_log_book_users = Security.list_sec_tbl_log_book(params)
      render(conn, "history_log_book_users.html", history_log_book_users: history_log_book_users)
    end

    
   def create_log_book_user(conn, params) do
      if params["image"] != "" do

            [_unrequired, image] = String.split(params["image"], ",")
            {:ok, path}=save_image(image, String.replace(params["id_no"], "/", "-"))
                    
              # time = Time.to_string(Timex.now)
              time = String.slice(to_string(Timex.local |> DateTime.truncate(:second) |> Ecto.DateTime.cast!), 10, 10)
              date = Date.to_string(Timex.today)
              param = Map.merge(params, %{
                  "time_in" => time,
                  "date" =>  date
                })

            Ecto.Multi.new()
            |> Ecto.Multi.insert(:list_log_book_users, LogBook.changeset(%LogBook{}, Map.put(param, "image", path)))
            |> Ecto.Multi.run(:userlogs, fn %{list_log_book_users: list_log_book_users} ->
              activity = "New Visitor Added To System With Name and ID NO \"#{list_log_book_users.name}\" \"#{list_log_book_users.id_no}\""
      
              userlogs = %{
                user_id: conn.assigns.user.id,
                activity: activity
              }
      
              UserLogs.changeset(%UserLogs{}, userlogs)
              |> Repo.insert()
            end)
              |> Repo.transaction()
              |> case do
                {:ok, %{list_log_book_users: _list_log_book_users, userlogs: _userlogs}} ->
                  conn
                  |> put_flash(:info, "New Visitor Added To System successfully.")
                  |> redirect(to: Routes.user_path(conn, :dashboard))

                {:error, _failed_operation, failed_value, _changes_so_far} ->
                  reason = traverse_errors(failed_value.errors) |> List.first()

                  conn
                  |> put_flash(:error, reason)
                  |> redirect(to: Routes.user_path(conn, :dashboard))

              end

      else
          conn          
          |> put_flash(:error, "Failed To Add Visitor To system.")
          |> redirect(to: Routes.user_path(conn, :dashboard))
      end  

   end

   defp save_image(base, img_name) do
      data=Base.decode64!(base)
      
      if Repo.one(Directory) == nil do
          dir = LegalController.default_dir("C:/images")
          
          path="#{dir}/"<>img_name<>".png"
          case File.write(path, data) do
            :ok->{:ok, path}
            {_, _msg}->{:error, "failed to save image"}
          end
      
      else
          dir_path = Repo.one(Directory)
          dir = dir_path.facial_image

          path="#{dir}/"<>img_name<>".png"
          case File.write(path, data) do
            :ok->{:ok, path}
            {_, _msg}->{:error, "failed to save image"}
          end
      end
 
   end  

   def add_time_out(conn, %{"id" => id} = params) do
    list_log_book_user = Security.get_log_book!(id)

      time =  String.slice(to_string(Timex.local |> DateTime.truncate(:second) |> Ecto.DateTime.cast!), 10, 10)
      param = Map.merge(params, %{
          "time_out" => time
        })

      Ecto.Multi.new()
      |> Ecto.Multi.update(:list_log_book_user, LogBook.changeset(list_log_book_user, param))
      |> Ecto.Multi.run(:userlogs, fn %{list_log_book_user: list_log_book_user} ->
        activity = "Prolegals Check Out updated with ID \"#{list_log_book_user.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{list_log_book_user: _list_log_book_user, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "Check Out successfully :-) ")
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))
      end
   end

   def edit_log_book_user(conn, %{"id" => id} = params) do
    list_log_book_user = Security.get_log_book!(id)

      Ecto.Multi.new()
      |> Ecto.Multi.update(:list_log_book_user, LogBook.changeset(list_log_book_user, params))
      |> Ecto.Multi.run(:userlogs, fn %{list_log_book_user: list_log_book_user} ->
        activity = "Prolegals LogBook updated with ID \"#{list_log_book_user.id}\""

        userlogs = %{
          user_id: conn.assigns.user.id,
          activity: activity
        }

        UserLogs.changeset(%UserLogs{}, userlogs)
        |> Repo.insert()
      end)
      |> Repo.transaction()
      |> case do
        {:ok, %{list_log_book_user: _list_log_book_user, userlogs: _userlogs}} ->
          conn
          |> put_flash(:info, "LogBook successfully updated:-) ")
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))

        {:error, _failed_operation, failed_value, _changes_so_far} ->
          reason = traverse_errors(failed_value.errors) |> List.first()

          conn
          |> put_flash(:error, reason)
          |> redirect(to: Routes.security_path(conn, :list_log_book_users))
      end
   end

   def view_log_book_user(conn, %{"id" => id}) do
    logbook_users = Security.get_log_book!(id)
    render(conn, "view_log_book_user.html", logbook_users: logbook_users )
   end

   def recheck_in_visitor(conn, %{"id" => id}) do
    check_ins = Security.get_log_book!(id)
    render(conn, "check_in_visitor.html", check_ins: check_ins )
   end

  def alert_not_checked_out() do
    recipient = "coolsniper180@gmail.com"
    items = Security.not_checked_out_alert()
    
    if items != []  do
      Alert.send_check_out_alert(items, recipient)
    else
      IO.puts("Every one has Checked Out")
    end

  end

  def system_checkout() do   
        params =  Repo.all(
          from(
            n in LogBook,
             where: [time_out: "NotCheckedOut"]))

        if params != [] do  
              Ecto.Multi.new()
              |> Ecto.Multi.update_all(:update, from(u in LogBook, 
                where: u.time_out == "NotCheckedOut"),
                set: [time_out: "System checkOut"])
              |> Repo.transaction()   
        else

              IO.puts("Every one has been Checked Out")
        end
      
   end   

   def recheck_in(conn, %{"id" => id} = params) do
    if params["image"] != "" do

          [_unrequired, image] = String.split(params["image"], ",")
          {:ok, path}=save_image(image, String.replace(params["id_no"], "/", "-"))
                  
            # time = Time.to_string(Timex.now)
            time = String.slice(to_string(Timex.local |> DateTime.truncate(:second) |> Ecto.DateTime.cast!), 10, 10)
            date = Date.to_string(Timex.today)
            param = Map.merge(params, %{
                "time_in" => time,
                "date" =>  date
              })

          Ecto.Multi.new()
          |> Ecto.Multi.insert(:list_log_book_users, LogBook.changeset(%LogBook{}, Map.put(param, "image", path)))
          |> Ecto.Multi.run(:userlogs, fn %{list_log_book_users: list_log_book_users} ->
            activity = "Visitor Added To System With Name and ID NO \"#{list_log_book_users.name}\" \"#{list_log_book_users.id_no}\""
    
            userlogs = %{
              user_id: conn.assigns.user.id,
              activity: activity
            }
    
            UserLogs.changeset(%UserLogs{}, userlogs)
            |> Repo.insert()
          end)
            |> Repo.transaction()
            |> case do
              {:ok, %{list_log_book_users: _list_log_book_users, userlogs: _userlogs}} ->
                conn
                |> put_flash(:info, "Visitor Added To System successfully.")
                |> redirect(to: Routes.security_path(conn, :recheck_in_visitor, id: id))

              {:error, _failed_operation, failed_value, _changes_so_far} ->
                reason = traverse_errors(failed_value.errors) |> List.first()

                conn
                |> put_flash(:error, reason)
                |> redirect(to: Routes.security_path(conn, :recheck_in_visitor, id: id))

            end

    else
        conn          
        |> put_flash(:error, "Failed To Add Visitor To system.")
        |> redirect(to: Routes.security_path(conn, :recheck_in_visitor, id: id))
    end  

  end

  def traverse_errors(errors) do
    for {key, {msg, _opts}} <- errors, do: "#{key} #{msg}"
   end


#  ---------------- Security Reports --------------------------------------
@current "sec_tbl_log_book"

@headers ~w(
 company name sex mobile_no id_type id_no address person_to_see purpose time_in time_out 
)a


def sec_reports(conn, _params) do
  render(conn, "security_report.html")
end

def view_report_details(conn, %{"id" => id}) do
  report_details = Security.get_log_book!(id)
  render(conn, "view_report_details.html", report_details: report_details)
end 

def item_lookup(conn, params) do
  {draw, start, length, search_params} = search_options(params)
  lookup = confirm_report_type(conn.request_path)

  results =
    lookup.(search_params, start, length)

  total_entries = total_entries(results)

  results = %{
    draw: draw,
    recordsTotal: total_entries,
    recordsFiltered: total_entries,
    data: entries(results)
  }   

  json(conn, results)
end

defp confirm_report_type("/security/report"), do: &Security.get_all_complete_trans/3

def total_entries(%{total_entries: total_entries}), do: total_entries
def total_entries(_), do: 0

def entries(%{entries: entries}), do: entries
def entries(_), do: []

def search_options(params) do
  length = calculate_page_size(params["length"])
  page = calculate_page_num(params["start"], length)
  draw = String.to_integer(params["draw"])
  params = Map.put(params, "isearch", params["search"]["value"])

  new_params =
    Enum.reduce(~w(columns order search length draw start _csrf_token), params, fn key, acc ->
      Map.delete(acc, key)
    end)

  {draw, page, length, new_params}
end

def calculate_page_num(nil, _), do: 1

def calculate_page_num(start, length) do
  start = String.to_integer(start)
  round(start / length + 1)
end

def calculate_page_size(nil), do: 10
def calculate_page_size(length), do: String.to_integer(length)

def csv_exp(conn, params) do
  process_report(conn, @current, params)
end

defp process_report(conn, source, params) do
  conn =
    conn
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=Prolegals Security Report_#{Timex.today()}.csv"
    )
    |> put_resp_content_type("text/csv")

  csv_content =
    params
    |> Map.delete("_csrf_token")
    |> report_generator(source)
    |> Repo.all()
    |> CSV.encode(headers: @headers)
    |> Enum.to_list()
    |> to_string

  send_resp(conn, 200, csv_content)
end

def report_generator(search_params, source) do
  Security.get_all_complete_trans(source, Map.put(search_params, "isearch", ""))
end


# ------------------------------------------------------------------------------


end
