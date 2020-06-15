defmodule Prolegals.Security do
  @moduledoc """
  The Security context.
  """

  import Ecto.Query, warn: false
  alias Prolegals.Repo

  alias Prolegals.Security.LogBook

  @doc """
  Returns the list of sec_tbl_log_book.

  ## Examples

      iex> list_sec_tbl_log_book()
      [%LogBook{}, ...]

  """
  def list_sec_tbl_log_book do
    Repo.all(LogBook)
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
end
