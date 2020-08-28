defmodule ProlegalsWeb.AdminController do
  use ProlegalsWeb, :controller

  alias Prolegals.{ Repo, Logs.UserLogs}
  alias Prolegals.Security
  alias Prolegals.Security.Inventory
  alias Prolegals.Security.Asset
  alias Prolegals.Security.Employee
  alias Prolegals.SystemDirectories.Directory
  alias Prolegals.Security.Location
  alias Prolegals.Security.Vendor


  plug(ProlegalsWeb.Plugs.RequireAuth when action in [
        :index,
        :inventory,
        :create_inventory,
        :update_inventory,
        :delete_inventory,
        :asset,
        :view_asset,
        :create_asset,
        :update_asset,
        :edit_asset,
        :delete_asset,
        :location,
        :create_location,
        :edit_location,
        :employee,
        :create_employee,
        :edit_employee,
        :vendor,
        :create_vendor,
        :edit_vendor,
        :handle_bulk_upload,
        :handle_file_upload,
        :process_csv,
        :process_bulk_upload,
        :prepare_bulk_params,
        :is_valide_file,
        :csv,
        :persist,
        :default_dir,
        :extract_xlsx,
        :traverse_errors

      ])


  @headers ~w/sn employee_name email contact nrc employee_no department /a

  def index(conn, _params) do
    render(conn, "index.html")
  end

  #------------------------------Inventory controller

  def inventory(conn, _params) do
    inventories = Security.list_sec_tbl_inventory_categories()
    render(conn, "inventory.html", inventories: inventories)
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
    all_assets = Security.get_assets_by_category!(id)
    locations = Security.list_sec_tbl_location()
    employees = Security.list_sec_tbl_employee()
    inventories = Security.get_inventory!(id)
    vendors = Security.list_sec_tbl_vendor()
    render(conn, "view_assets.html", all_assets: all_assets, inventories: inventories, locations: locations, employees: employees, vendors: vendors)
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

  def edit_asset(conn, %{"id" => id} = params) do
    assets = Security.get_asset!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:assets, Asset.changeset(assets, params))
    |> Ecto.Multi.run(:userlogs, fn %{assets: assets} ->
      activity = "Asset Editted with ID \"#{assets.id}\""

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

  
  def edit_location(conn, %{"id" => id} = params) do
    locations = Security.get_location!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:locations, Location.changeset(locations, params))
    |> Ecto.Multi.run(:userlogs, fn %{locations: locations} ->
      activity = "Location Editted with ID \"#{locations.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{locations: _locations, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "The Location Has Been Updated Successfully")
        |> redirect(to: Routes.admin_path(conn, :location))

        {:error, %{locations: _locations, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed To Update The Location details.")
          |> redirect(to: Routes.admin_path(conn, :location))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
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

  def edit_employee(conn, %{"id" => id} = params) do
    employees = Security.get_employee!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:employees, Employee.changeset(employees, params))
    |> Ecto.Multi.run(:userlogs, fn %{employees: employees} ->
      activity = "Employee Editted with ID \"#{employees.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{employees: _employees, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "The Employee Has Been Updated Successfully")
        |> redirect(to: Routes.admin_path(conn, :employee))

        {:error, %{employees: _employees, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed To Update The Employee details.")
          |> redirect(to: Routes.admin_path(conn, :employee))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
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

  def edit_vendor(conn, %{"id" => id} = params) do
    vendors = Security.get_vendor!(id)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:vendors, Vendor.changeset(vendors, params))
    |> Ecto.Multi.run(:userlogs, fn %{vendors: vendors} ->
      activity = "Vendor Editted with ID \"#{vendors.id}\""

      userlogs = %{
        user_id: conn.assigns.user.id,
        activity: activity
      }

      UserLogs.changeset(%UserLogs{}, userlogs)
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{vendors: _vendors, userlogs: _userlogs}} ->
        conn
        |> put_flash(:info, "The Vendor Has Been Updated Successfully")
        |> redirect(to: Routes.admin_path(conn, :vendor))

        {:error, %{vendors: _vendors, userlogs: _userlogs}} ->
          conn
          |> put_flash(:error, "Failed To Update The Vendor details.")
          |> redirect(to: Routes.admin_path(conn, :vendor))
        # {:error, failed_operation, failed_value, changes_so_far} ->
        #   reason = VehicleController.traverse_errors(failed_value.errors) |> List.first()

        # conn
        # |> put_flash(:error, reason)
        # |> redirect(to: Routes.vehicle_path(conn, :list_vehicles))
      end
  end

  # ---------------------------------- File upload
 
  def handle_bulk_upload(conn, params) do
    user = conn.assigns.user
    
    {key, msg, _invalid} = handle_file_upload(user, params)
  
    if key == :info do
      conn
      |> put_flash(key, msg)
      |> redirect(to: Routes.admin_path(conn, :employee))

    else
      conn
      |> put_flash(key, msg)
      |> redirect(to: Routes.admin_path(conn, :employee))
    end
  end


  defp handle_file_upload(user, params) do
  
    with {:ok, filename, destin_path, _rows} <- is_valide_file(params) do
      user
      |> process_bulk_upload(filename, destin_path)
      |> case do
        {:ok, {invalid, valid}} ->
          {:info, "#{valid} Successful entrie(s) and #{invalid} invalid entrie(s)", invalid}

        {:error, reason} ->
          {:error, reason, 0}
      end
    else
      {:error, reason} ->
        {:error, reason, 0}
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

  def process_bulk_upload(user, filename, path) do
    # try do
      {:ok, items} = extract_xlsx(path)

      prepare_bulk_params(user, filename, items)
      |> Repo.transaction(timeout: 290_000)
      |> case do
        {:ok, multi_records} ->
          {invalid, valid} =
            multi_records
            |> Map.values()
            |> Enum.reduce({0, 0}, fn item, {invalid, valid} ->
              case item do
                %{employee_bulk_filename: _src} -> {invalid, valid + 1}
                %{col_index: _index} -> {invalid + 1, valid}
                _ -> {invalid, valid}
              end
            end)

          {:ok, {invalid, valid}}

        {:error, _, changeset, _} ->
          # prepare_error_log(changeset, filename)
          reason = traverse_errors(changeset.errors) |> Enum.join("\r\n")
          {:error, reason}
      end
    # after
    #   filename = Path.rootname(filename) |> Path.basename()
    # end
  end

  defp prepare_bulk_params(user, filename, items) do
 
    items
    |> Stream.with_index(2)
    |> Stream.map(fn {item, index} ->
      changeset =
        %Employee{employee_bulk_filename: filename} 
        |> Employee.changeset(Map.put(item, :user_id, user.id))

      Ecto.Multi.insert(Ecto.Multi.new(), Integer.to_string(index), changeset)

    end)

    # |> filter_upload_errors(filename)
    |> Enum.reject(fn
      %{operations: [{_, {:run, _}}]} -> false
      %{operations: [{_, {_, changeset, _}}]} -> changeset.valid? == false
    end)
    |> Enum.reduce(Ecto.Multi.new(), &Ecto.Multi.append/2)
  end

  # ---------------------- file persistence --------------------------------------
  def is_valide_file(%{"employee_bulk_filename" => params}) do
      if upload = params do
        case Path.extname(upload.filename) do
          ext when ext in ~w(.xlsx .XLSX .xls .XLS .csv .CSV) ->
            with {:ok, destin_path} <- persist(upload) do
              case ext not in ~w(.csv .CSV) do
                true ->
                  case Xlsxir.multi_extract(destin_path, 0, false, extract_to: :memory) do
                    {:ok, table_id} ->
                      row_count = Xlsxir.get_info(table_id, :rows)
                      Xlsxir.close(table_id)
                      {:ok, upload.filename, destin_path, row_count - 1}
  
                    {:error, reason} ->
                      {:error, reason}
                  end
  
                _ ->
                  {:ok, upload.filename, destin_path, "N(count)"}
              end
            else
              {:error, reason} ->
                {:error, reason}
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
        IO.inspect("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        IO.inspect(row_count)

        case row_count do
          rows when rows in 1..100_000 ->
            {:ok, upload.filename, path, row_count}

          _ ->
            {:error, "File records should be between 1 to 100,000"}
        end

      {:error, reason} ->
        IO.inspect(reason)

        {:error, reason}
    end
  end


    def persist(%Plug.Upload{filename: filename, path: path}) do
      dir_path = Repo.one(Directory)

      destin_path = (dir_path && dir_path.processed)  || "C:/Employees/file" |> default_dir()
      destin_path = Path.join(destin_path, filename)

        {_key, _resp} =
        with true <- File.exists?(destin_path) do
          {:error, "File with the same name aready exists"}
        else
          false ->
            File.cp(path, destin_path)
            {:ok, destin_path}
        end
    end
    

    def default_dir(path) do
      File.mkdir_p(path)
      path
    end


  def extract_xlsx(path) do
    case Xlsxir.multi_extract(path, 0, false, extract_to: :memory) do
      {:ok, id} ->
        items =
          Xlsxir.get_list(id)
          |> Enum.reject(&Enum.empty?/1)
          |> Enum.reject(&Enum.all?(&1, fn item -> is_nil(item) 
        end))
          |> List.delete_at(0)
          |> Enum.map(
            &Enum.zip(
              Enum.map(@headers, fn h -> h end),
              Enum.map(&1, fn v -> strgfy_term(v) end)
            )
          )
          |> Enum.map(&Enum.into(&1, %{}))
          |> Enum.uniq_by(&String.trim(&1.nrc))
          |> Enum.reject(&(Enum.join(Map.values(&1)) == ""))

        Xlsxir.close(id)
        {:ok, items}


      {:error, reason} ->
        {:error, reason}
    end
  end

    defp strgfy_term(term) when is_tuple(term), do: term
    defp strgfy_term(term) when not is_tuple(term), do: String.trim("#{term}")

  
# -------------------------------------------------------------------------------

def traverse_errors(errors) do
  for {key, {msg, _opts}} <- errors, do: "#{key} #{msg}"
end

end
