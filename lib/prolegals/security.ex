defmodule Prolegals.Security do
  @moduledoc """
  The Security context.
  """

  import Ecto.Query, warn: false
  alias Prolegals.Repo

  alias Prolegals.Security.LogBook
  alias Prolegals.Security.AmmunitionInventory
  alias Prolegals.Security.FirearmsInventory



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



  # --------------------------------------------------------------------------------- Firearms Inventory

  alias Prolegals.Security.FirearmsInventory

  @doc """
  Returns the list of sec_tbl_firearms.

  ## Examples

      iex> list_sec_tbl_firearms()
      [%FirearmsInventory{}, ...]

  """
  def list_sec_tbl_firearms do
    Repo.all(FirearmsInventory)
  end

  @doc """
  Gets a single firearms_inventory.

  Raises `Ecto.NoResultsError` if the Firearms inventory does not exist.

  ## Examples

      iex> get_firearms_inventory!(123)
      %FirearmsInventory{}

      iex> get_firearms_inventory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_firearms_inventory!(id), do: Repo.get!(FirearmsInventory, id)

  @doc """
  Creates a firearms_inventory.

  ## Examples

      iex> create_firearms_inventory(%{field: value})
      {:ok, %FirearmsInventory{}}

      iex> create_firearms_inventory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_firearms_inventory(attrs \\ %{}) do
    %FirearmsInventory{}
    |> FirearmsInventory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a firearms_inventory.

  ## Examples

      iex> update_firearms_inventory(firearms_inventory, %{field: new_value})
      {:ok, %FirearmsInventory{}}

      iex> update_firearms_inventory(firearms_inventory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_firearms_inventory(%FirearmsInventory{} = firearms_inventory, attrs) do
    firearms_inventory
    |> FirearmsInventory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a firearms_inventory.

  ## Examples

      iex> delete_firearms_inventory(firearms_inventory)
      {:ok, %FirearmsInventory{}}

      iex> delete_firearms_inventory(firearms_inventory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_firearms_inventory(%FirearmsInventory{} = firearms_inventory) do
    Repo.delete(firearms_inventory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking firearms_inventory changes.

  ## Examples

      iex> change_firearms_inventory(firearms_inventory)
      %Ecto.Changeset{source: %FirearmsInventory{}}

  """
  def change_firearms_inventory(%FirearmsInventory{} = firearms_inventory) do
    FirearmsInventory.changeset(firearms_inventory, %{})
  end

  # --------------------------------------------------------------------------------- Ammunition Inventory
  alias Prolegals.Security.AmmunitionInventory

  @doc """
  Returns the list of sec_tbl_ammunition.

  ## Examples

      iex> list_sec_tbl_ammunition()
      [%AmmunitionInventory{}, ...]

  """
  def list_sec_tbl_ammunition do
    Repo.all(AmmunitionInventory)
  end

  @doc """
  Gets a single ammunition_inventory.

  Raises `Ecto.NoResultsError` if the Ammunition inventory does not exist.

  ## Examples

      iex> get_ammunition_inventory!(123)
      %AmmunitionInventory{}

      iex> get_ammunition_inventory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ammunition_inventory!(id), do: Repo.get!(AmmunitionInventory, id)

  @doc """
  Creates a ammunition_inventory.

  ## Examples

      iex> create_ammunition_inventory(%{field: value})
      {:ok, %AmmunitionInventory{}}

      iex> create_ammunition_inventory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ammunition_inventory(attrs \\ %{}) do
    %AmmunitionInventory{}
    |> AmmunitionInventory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ammunition_inventory.

  ## Examples

      iex> update_ammunition_inventory(ammunition_inventory, %{field: new_value})
      {:ok, %AmmunitionInventory{}}

      iex> update_ammunition_inventory(ammunition_inventory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ammunition_inventory(%AmmunitionInventory{} = ammunition_inventory, attrs) do
    ammunition_inventory
    |> AmmunitionInventory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ammunition_inventory.

  ## Examples

      iex> delete_ammunition_inventory(ammunition_inventory)
      {:ok, %AmmunitionInventory{}}

      iex> delete_ammunition_inventory(ammunition_inventory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ammunition_inventory(%AmmunitionInventory{} = ammunition_inventory) do
    Repo.delete(ammunition_inventory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ammunition_inventory changes.

  ## Examples

      iex> change_ammunition_inventory(ammunition_inventory)
      %Ecto.Changeset{source: %AmmunitionInventory{}}

  """
  def change_ammunition_inventory(%AmmunitionInventory{} = ammunition_inventory) do
    AmmunitionInventory.changeset(ammunition_inventory, %{})
  end
end
