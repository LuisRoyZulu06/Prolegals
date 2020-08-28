defmodule Prolegals.Security do
  @moduledoc """
  The Security context.
  """
  import Ecto.Query, only: [from: 2]
  import Ecto.Query, warn: false
  alias Prolegals.Repo

  alias Prolegals.Security.LogBook
  alias Prolegals.Security.Inventory
 



  @doc """
  Returns the list of sec_tbl_log_book.Prolegals.Security.not_checked_out

  ## Examples

      iex> list_sec_tbl_log_book()
      [%LogBook{}, ...]

  """
  def list_sec_tbl_log_book(params) do
    search_term = get_in(params, ["query"])
    LogBook
    |> LogBook.search(search_term)
    |> Repo.all()
  end
  def not_checked_out_alert() do
    current_date = to_string(Timex.today)
    Repo.all(from(n in LogBook, where: [time_out: "NotCheckedOut", date: ^current_date ]))
  end

  # def system_checkout_query do
  #  Repo.all(
  #    from(
  #      n in LogBook,
  #       where: [time_out: "NotCheckedOut"]))
  # end
  

  def get_user_details(id) do
    Repo.get!(User, id)
  end
  

  @doc """
  Gets a single log_book.

  Raises `Ecto.NoResultsError` if the Log book does not exist.

  ## Examples

      iex> get_log_book!(123)
      %LogBook{}

      iex> get_log_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log_book!(id), do: Repo.get!(LogBook, id)

  @doc """
  Creates a log_book.

  ## Examples

      iex> create_log_book(%{field: value})
      {:ok, %LogBook{}}

      iex> create_log_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log_book(attrs \\ %{}) do
    %LogBook{}
    |> LogBook.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a log_book.

  ## Examples

      iex> update_log_book(log_book, %{field: new_value})
      {:ok, %LogBook{}}

      iex> update_log_book(log_book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_log_book(%LogBook{} = log_book, attrs) do
    log_book
    |> LogBook.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a log_book.

  ## Examples

      iex> delete_log_book(log_book)
      {:ok, %LogBook{}}

      iex> delete_log_book(log_book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log_book(%LogBook{} = log_book) do
    Repo.delete(log_book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log_book changes.

  ## Examples

      iex> change_log_book(log_book)
      %Ecto.Changeset{source: %LogBook{}}

  """
  def change_log_book(%LogBook{} = log_book) do
    LogBook.changeset(log_book, %{})
  end

  # --------------------------------- Security Dashboard Statistic-----------------------
  
  def frequent_visitors do
    query =

    """
    SELECT id_no, COUNT(DISTINCT id_no)
    FROM sec_tbl_log_book
    GROUP BY id_no
    HAVING COUNT(id_no) > 2

    """
    
    {:ok, %{columns: columns, rows: rows}} = Repo.query(query, [])
    rows |> Enum.map(&Enum.zip(columns, &1)) |> Enum.map(&Enum.into(&1, %{})) |> Enum.count()
  end

  def total_visitors do
    
    Repo.one(from p in "sec_tbl_log_book", select:  count(p.id))
  end

  def visitors_not_checked_out do
    current_date = to_string(Timex.today)
    Repo.all(from u in LogBook, where: u.time_out == "NotCheckedOut" and u.date == ^current_date )|> Enum.count
  end

  # ---------------------------  SECURITY REPORT ----------------------------

  def get_all_complete_trans(search_params, page, size) do
    LogBook
    |> handle_report_filter(search_params)
    |> order_by(desc: :inserted_at)
    |> compose_report_select()
    |> Repo.paginate(page: page, page_size: size)
  end

  #CSV Report
  def get_all_complete_trans(_source, search_params) do
    LogBook
    |> handle_report_filter(search_params)
    |> order_by(desc: :inserted_at)
    |> compose_report_select()
  end

  defp handle_report_filter(query, %{"isearch" => search_term} = search_params)
  when search_term == "" or is_nil(search_term) do
  query
  |> handle_date_filter(search_params)
  |> handle_mobile_filter(search_params)
  |> handle_id_num_filter(search_params)
  end

  defp handle_report_filter(query, %{"isearch" => search_term}) do
  search_term = "%#{search_term}%"
  compose_isearch_filter(query, search_term)
  end

  defp handle_date_filter(query, %{"from" => from, "to" => to})
        when from == "" or is_nil(from) or to == "" or is_nil(to),
        do: query

  defp handle_date_filter(query, %{"from" => from, "to" => to}) do
    query
    |> where(
      [a],
      fragment("CAST(? AS DATE) >= ?", a.inserted_at, ^from) and
        fragment("CAST(? AS DATE) <= ?", a.inserted_at, ^to)
    )
  end

  defp handle_id_num_filter(query, %{"id_no" => id_no})
  when id_no == "" or is_nil(id_no),
  do: query

  defp handle_id_num_filter(query, %{"id_no" => id_no}) do
  where(query, [a], fragment("lower(?) LIKE lower(?)", a.id_no, ^"%#{id_no}%"))
  end

  defp handle_mobile_filter(query, %{"mobile_no" => mobile_no})
       when mobile_no == "" or is_nil(mobile_no),
       do: query

  defp handle_mobile_filter(query, %{"mobile_no" => mobile_no}) do
    where(query, [a], fragment("lower(?) LIKE lower(?)", a.mobile_no, ^"%#{mobile_no}%"))
  end

  defp compose_isearch_filter(query, search_term) do
    query
    |> where(
      [a],
        fragment("lower(?) LIKE lower(?)", a.company, ^search_term) or 
        fragment("lower(?) LIKE lower(?)", a.name, ^search_term) or 
        fragment("lower(?) LIKE lower(?)", a.address, ^search_term) or 
        fragment("lower(?) LIKE lower(?)", a.mobile_no, ^search_term) or 
        fragment("lower(?) LIKE lower(?)", a.person_to_see, ^search_term) or 
        fragment("lower(?) LIKE lower(?)", a.purpose, ^search_term) or 
        fragment("lower(?) LIKE lower(?)", a.id_type, ^search_term) or 
        fragment("lower(?) LIKE lower(?)", a.id_no, ^search_term)
            
    )
  end

  defp compose_report_select(query) do
    query
    |> select(
      [a],
      map(a, [
        :company,
        :name,
        :sex,
        :address,
        :mobile_no,
        :person_to_see,
        :purpose,  
        :id_type,
        :id_no,
        :time_in,
        :time_out,
        :id
      ])
    )
  end


  # -------------------------------------------------------------------------

  alias Prolegals.Security.Inventory

  @doc """
  Returns the list of sec_tbl_inventory_categories.

  ## Examples

      iex> list_sec_tbl_inventory_categories()
      [%Inventory{}, ...]

  """
  def list_sec_tbl_inventory_categories do
    Repo.all(Inventory)
  end

  @doc """
  Gets a single inventory.

  Raises `Ecto.NoResultsError` if the Inventory does not exist.

  ## Examples

      iex> get_inventory!(123)
      %Inventory{}

      iex> get_inventory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_inventory!(id), do: Repo.get!(Inventory, id)

  @doc """
  Creates a inventory.

  ## Examples

      iex> create_inventory(%{field: value})
      {:ok, %Inventory{}}

      iex> create_inventory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory(attrs \\ %{}) do
    %Inventory{}
    |> Inventory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a inventory.

  ## Examples

      iex> update_inventory(inventory, %{field: new_value})
      {:ok, %Inventory{}}

      iex> update_inventory(inventory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory(%Inventory{} = inventory, attrs) do
    inventory
    |> Inventory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a inventory.

  ## Examples

      iex> delete_inventory(inventory)
      {:ok, %Inventory{}}

      iex> delete_inventory(inventory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory(%Inventory{} = inventory) do
    Repo.delete(inventory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory changes.

  ## Examples

      iex> change_inventory(inventory)
      %Ecto.Changeset{source: %Inventory{}}

  """
  def change_inventory(%Inventory{} = inventory) do
    Inventory.changeset(inventory, %{})
  end

  # -----------------Admin Dashboard Statistic------------------------------------

  def total_inventory do
    Repo.one(from p in "sec_tbl_inventory_categories", select:  count(p.id))
  end

  # --------------------------------------------------------------------------------

  alias Prolegals.Security.Asset

  @doc """
  Returns the list of sec_tbl_assets.

  ## Examples

      iex> list_sec_tbl_assets()
      [%Asset{}, ...]

  """
  def list_sec_tbl_assets do
    Repo.all(Asset)
  end


  @doc """
  Gets a single asset.

  Raises `Ecto.NoResultsError` if the Asset does not exist.

  ## Examples

      iex> get_asset!(123)
      %Asset{}

      iex> get_asset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_asset!(id), do: Repo.get!(Asset, id)

  def get_assets_by_category!(id) do
    Asset
    |> where([e], e.category_id == ^id)
    |>Repo.all()
  end
  @doc """
  Creates a asset.

  ## Examples

      iex> create_asset(%{field: value})
      {:ok, %Asset{}}

      iex> create_asset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_asset(attrs \\ %{}) do
    %Asset{}
    |> Asset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a asset.

  ## Examples

      iex> update_asset(asset, %{field: new_value})
      {:ok, %Asset{}}

      iex> update_asset(asset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_asset(%Asset{} = asset, attrs) do
    asset
    |> Asset.changeset(attrs)
    |> Repo.update()
  end



  @doc """
  Deletes a asset.

  ## Examples

      iex> delete_asset(asset)
      {:ok, %Asset{}}

      iex> delete_asset(asset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_asset(%Asset{} = asset) do
    Repo.delete(asset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking asset changes.

  ## Examples

      iex> change_asset(asset)
      %Ecto.Changeset{source: %Asset{}}

  """
  def change_asset(%Asset{} = asset) do
    Asset.changeset(asset, %{})
  end

  
   # -----------------Admin Dashboard Statistic------------------------------------

   def total_assets do
    Repo.one(from p in "sec_tbl_assets", select:  count(p.id))
   end

   def assigned_assest do
    Repo.all(from u in Asset, where: u.assaigned == "Assigned"  )|> Enum.count
   end

   def unassigned_assest do
    Repo.all(from u in Asset, where: u.assaigned == "Unassigned"  )|> Enum.count
   end

  # --------------------------------------------------------------------------------

  alias Prolegals.Security.Location

  @doc """
  Returns the list of sec_tbl_location.

  ## Examples

      iex> list_sec_tbl_location()
      [%Location{}, ...]

  """
  def list_sec_tbl_location do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{source: %Location{}}

  """
  def change_location(%Location{} = location) do
    Location.changeset(location, %{})
  end

   # -----------------Admin Dashboard Statistic------------------------------------

   def total_location do
    Repo.one(from p in "sec_tbl_location", select:  count(p.id))
   end

  # --------------------------------------------------------------------------------

  alias Prolegals.Security.Vendor

  @doc """
  Returns the list of sec_tbl_vendor.

  ## Examples

      iex> list_sec_tbl_vendor()
      [%Vendor{}, ...]

  """
  def list_sec_tbl_vendor do
    Repo.all(Vendor)
  end

  @doc """
  Gets a single vendor.

  Raises `Ecto.NoResultsError` if the Vendor does not exist.

  ## Examples

      iex> get_vendor!(123)
      %Vendor{}

      iex> get_vendor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vendor!(id), do: Repo.get!(Vendor, id)

  @doc """
  Creates a vendor.

  ## Examples

      iex> create_vendor(%{field: value})
      {:ok, %Vendor{}}

      iex> create_vendor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vendor(attrs \\ %{}) do
    %Vendor{}
    |> Vendor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vendor.

  ## Examples

      iex> update_vendor(vendor, %{field: new_value})
      {:ok, %Vendor{}}

      iex> update_vendor(vendor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vendor(%Vendor{} = vendor, attrs) do
    vendor
    |> Vendor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vendor.

  ## Examples

      iex> delete_vendor(vendor)
      {:ok, %Vendor{}}

      iex> delete_vendor(vendor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vendor(%Vendor{} = vendor) do
    Repo.delete(vendor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vendor changes.

  ## Examples

      iex> change_vendor(vendor)
      %Ecto.Changeset{source: %Vendor{}}

  """
  def change_vendor(%Vendor{} = vendor) do
    Vendor.changeset(vendor, %{})
  end

  # -----------------Admin Dashboard Statistic------------------------------------

  def total_vendors do
    Repo.one(from p in "sec_tbl_vendor", select:  count(p.id))
  end



  # --------------------------------------------------------------------------------



  alias Prolegals.Security.Employee

  @doc """
  Returns the list of sec_tbl_employee.

  ## Examples

      iex> list_sec_tbl_employee()
      [%Employee{}, ...]

  """
  def list_sec_tbl_employee do
    Repo.all(Employee)
  end

  @doc """
  Gets a single employee.

  Raises `Ecto.NoResultsError` if the Employee does not exist.

  ## Examples

      iex> get_employee!(123)
      %Employee{}

      iex> get_employee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_employee!(id), do: Repo.get!(Employee, id)

  @doc """
  Creates a employee.

  ## Examples

      iex> create_employee(%{field: value})
      {:ok, %Employee{}}

      iex> create_employee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_employee(attrs \\ %{}) do
    %Employee{}
    |> Employee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a employee.

  ## Examples

      iex> update_employee(employee, %{field: new_value})
      {:ok, %Employee{}}

      iex> update_employee(employee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_employee(%Employee{} = employee, attrs) do
    employee
    |> Employee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a employee.

  ## Examples

      iex> delete_employee(employee)
      {:ok, %Employee{}}

      iex> delete_employee(employee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_employee(%Employee{} = employee) do
    Repo.delete(employee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking employee changes.

  ## Examples

      iex> change_employee(employee)
      %Ecto.Changeset{source: %Employee{}}

  """
  def change_employee(%Employee{} = employee) do
    Employee.changeset(employee, %{})
  end

end
