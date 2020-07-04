defmodule ProlegalsWeb.AdminController do
  use ProlegalsWeb, :controller

  alias Prolegals.{Logs, Repo, Logs.UserLogs, Auth}
  alias Prolegals.Security
  alias Prolegals.Security.Inventory
  alias Prolegals.Security.Asset
  alias Prolegals.Security.Employee
  alias Prolegals.SystemDirectories.Directory

  def index(conn, _params) do
    render(conn, "index.html")
  end


  #------------------------------Inventory controller

  def inventory(conn, _params) do
    inventories = Security.list_sec_tbl_inventory_categories()
    render(conn, "inventory.html", inventories: inventories)
  end

  def view_assets(conn, %{"id" => id}) do
    inventories = Security.get_inventory!(id)
    render(conn, "view_assets.html", inventories: inventories)
  end

  def create_inventory(conn, params) do
  	case Security.create_inventory(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "A New Inventory Category Has Been Added Successfully.")
            |> redirect(to: Routes.admin_path(conn, :inventory))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add A New Category!")
            |> redirect(to: Routes.admin_path(conn, :inventory))
    end
  end

  def update_inventory(conn, %{"id" => id} = params) do
    inventories = Security.get_inventory!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:inventories, Inventory.changeset(inventories, params))
    |> Ecto.Multi.run(:userlogs, fn %{inventories: inventories} ->
      activity = "Category updated with ID \"#{inventories.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{inventories: _inventories, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "Category Has Been Updated Successfully")
        |> redirect(to: Routes.admin_path(conn, :inventory))

        {:error, %{firearms: _firearms, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed To Update Category Details.")
          |> redirect(to: Routes.admin_path(conn, :inventory))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
      end
  end

  def delete_inventory(conn, %{"id" => id}) do
    inventories = Security.get_inventory!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.delete(:inventories, inventories)
    |> Ecto.Multi.run(:userlogs, fn %{inventories: inventories} ->
      activity = "Category Deleted \"#{inventories.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{inventories: _inventories, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "Category Has Been Deleted.")
        |> redirect(to: Routes.admin_path(conn, :inventory))

      # {:error, _failed_operation, failed_value, _changes_so_far} ->
      #  reason = AdminController._traverse_errors(failed_value.errors) |> List.first()

      #  conn
      #  |> put_flash(:error, reason)
      #  |> redirect(to: Routes.admin_path(conn, :inventory))
    end
  end

  # ------------------------------------ Assets Controller

  def asset(conn, _params) do
    assets = Security.list_sec_tbl_assets()
    inventories = Security.list_sec_tbl_inventory_categories()
    vendors = Security.list_sec_tbl_vendor()
    render(conn, "assets.html", assets: assets, inventories: inventories, vendors: vendors)
  end



  def view_asset(conn, %{"id" => id}) do
    assets = Security.get_asset!(id)
    all_assets = Security.get_all_assets!(id)
    locations = Security.list_sec_tbl_location()
    employees = Security.list_sec_tbl_employee()
    inventories = Security.get_inventory!(id)
    vendors = Security.list_sec_tbl_vendor()
    render(conn, "view_assets.html", assets: assets, all_assets: all_assets, inventories: inventories, locations: locations, employees: employees, vendors: vendors)
  end


  def create_asset(conn, params) do
  	case Security.create_asset(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "A New Asset Has Been Added successfully.")
            |> redirect(to: Routes.admin_path(conn, :asset))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add Asset!")
            |> redirect(to: Routes.admin_path(conn, :asset))
    end
  end

  def update_asset(conn, %{"id" => id} = params) do
    assets = Security.get_asset!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:assets, Asset.changeset(assets, params))
    |> Ecto.Multi.run(:userlogs, fn %{assets: assets} ->
      activity = "Asset updated with ID \"#{assets.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{assets: _assets, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "The Asset Has Been Updated Successfully")
        |> redirect(to: Routes.admin_path(conn, :asset))

        {:error, %{firearms: _firearms, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed To uUpdate The Asset details.")
          |> redirect(to: Routes.admin_path(conn, :asset))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
      end
  end

  def delete_asset(conn, %{"id" => id}) do
    assets = Security.get_asset!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.delete(:assets, assets)
    |> Ecto.Multi.run(:userlogs, fn %{assets: assets} ->
      activity = "Asset Deleted \"#{assets.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{assets: _assets, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "Asset Deleted.")
        |> redirect(to: Routes.admin_path(conn, :asset))

      # {:error, _failed_operation, failed_value, _changes_so_far} ->
      #  reason = AdminController._traverse_errors(failed_value.errors) |> List.first()

      #  conn
      #  |> put_flash(:error, reason)
      #  |> redirect(to: Routes.admin_path(conn, :inventory))
    end
  end

  # ------------------------------------ location Controller

  def location(conn, _params) do
    locations = Security.list_sec_tbl_location()
    render(conn, "location.html", locations: locations)
  end

  @spec create_location(Plug.Conn.t(), :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) :: Plug.Conn.t()
  def create_location(conn, params) do
  	case Security.create_location(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "A New Office Location Has Been Added Successfully.")
            |> redirect(to: Routes.admin_path(conn, :location))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add A New Office Location!")
            |> redirect(to: Routes.admin_path(conn, :location))
    end
  end

  # ------------------------------------ Employees Controller

  def employee(conn, _params) do
    employees = Security.list_sec_tbl_employee()
    render(conn, "employee.html", employees: employees)
  end

  def create_employee(conn, params) do
  	case Security.create_employee(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "A New Employee Has Been Added Successfully.")
            |> redirect(to: Routes.admin_path(conn, :employee))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add A New Employee!")
            |> redirect(to: Routes.admin_path(conn, :employee))
    end
  end

   # ------------------------------------ Vendor Controller

   def vendor(conn, _params) do
    vendors = Security.list_sec_tbl_vendor()
    render(conn, "vendor.html", vendors: vendors)
  end

  def create_vendor(conn, params) do
  	case Security.create_vendor(params) do
          {:ok, _} ->
            conn
            |> put_flash(:info, "A New Vendor Has Been Added Successfully.")
            |> redirect(to: Routes.admin_path(conn, :vendor))

            conn

          {:error, _} ->
            conn
            |> put_flash(:error, "Failed To Add A New Vendor!")
            |> redirect(to: Routes.admin_path(conn, :vendor))
    end
  end

  # ---------------------------------- File upload
	def create_bulk_employee(conn, params) do
    {key, msg} = handle_employee(params)
    conn
    |> put_flash(key, msg)
    |> redirect(to: Routes.admin_path(conn, :employee))

    # rescue
    #   _ ->
    #     conn
    #     |> put_flash(:error, "Something went wrong. try again")
    #     |> redirect(to: Routes.message_path(conn, :broadcast_sms))
end

defp handle_employee(params) do
# user,
with {:ok, filename, destin_path, rows} <- is_file_valid(params) do
  enque_upload(filename, destin_path)
    # user,
    {:info, "#{rows} Employees added."}
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
      changeset = Employee.changeset(%Employee{},item)

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



def is_file_valid(%{"employee_bulk_filename" => params}) do
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
    destin_path = (dir_path && dir_path.processed) || "D:/prodoc" |> default_dir()
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
