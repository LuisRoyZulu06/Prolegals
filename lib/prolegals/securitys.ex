defmodule Prolegals.Securitys do
  @moduledoc """
  The Securitys context.
  """

  import Ecto.Query, warn: false
  alias Prolegals.Repo

  alias Prolegals.Securitys.Log_book

  @doc """
  Returns the list of tbl_log_book.

  ## Examples

      iex> list_tbl_log_book()
      [%Log_book{}, ...]

  """
  def list_tbl_log_book do
    Repo.all(Log_book)
  end

  @doc """
  Gets a single log_book.

  Raises `Ecto.NoResultsError` if the Log book does not exist.

  ## Examples

      iex> get_log_book!(123)
      %Log_book{}

      iex> get_log_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log_book!(id), do: Repo.get!(Log_book, id)

  @doc """
  Creates a log_book.

  ## Examples

      iex> create_log_book(%{field: value})
      {:ok, %Log_book{}}

      iex> create_log_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log_book(attrs \\ %{}) do
    %Log_book{}
    |> Log_book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a log_book.

  ## Examples

      iex> update_log_book(log_book, %{field: new_value})
      {:ok, %Log_book{}}

      iex> update_log_book(log_book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_log_book(%Log_book{} = log_book, attrs) do
    log_book
    |> Log_book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a log_book.

  ## Examples

      iex> delete_log_book(log_book)
      {:ok, %Log_book{}}

      iex> delete_log_book(log_book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log_book(%Log_book{} = log_book) do
    Repo.delete(log_book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log_book changes.

  ## Examples

      iex> change_log_book(log_book)
      %Ecto.Changeset{source: %Log_book{}}

  """
  def change_log_book(%Log_book{} = log_book) do
    Log_book.changeset(log_book, %{})
  end
end
