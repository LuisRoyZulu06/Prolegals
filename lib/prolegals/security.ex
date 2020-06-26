defmodule Prolegals.Security do
  @moduledoc """
  The Security context.
  """

  import Ecto.Query, warn: false
  alias Prolegals.Repo

  alias Prolegals.Security.LogBook
  alias Prolegals.Security.Inventory



  @doc """
  Returns the list of sec_tbl_log_book.

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

  def get_asset_by_category(id) do
    Repo.get_by(Inventory, category_id: id)
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
end
