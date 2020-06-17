defmodule Prolegals.Litigation do
  @moduledoc """
  The Litigation context.
  """

  import Ecto.Query, warn: false
  alias Prolegals.Repo

  # ----------------------------------------------------------------------------------Contacts
  alias Prolegals.Litigation.Contacts

  @doc """
  Returns the list of li_tbl_contacts.

  ## Examples

      iex> list_li_tbl_contacts()
      [%Contacts{}, ...]

  """
  def list_li_tbl_contacts do
    Repo.all(Contacts)
  end

  @doc """
  Gets a single contacts.

  Raises `Ecto.NoResultsError` if the Contacts does not exist.

  ## Examples

      iex> get_contacts!(123)
      %Contacts{}

      iex> get_contacts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contacts!(id), do: Repo.get!(Contacts, id)

  @doc """
  Creates a contacts.

  ## Examples

      iex> create_contacts(%{field: value})
      {:ok, %Contacts{}}

      iex> create_contacts(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contacts(attrs \\ %{}) do
    %Contacts{}
    |> Contacts.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contacts.

  ## Examples

      iex> update_contacts(contacts, %{field: new_value})
      {:ok, %Contacts{}}

      iex> update_contacts(contacts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contacts(%Contacts{} = contacts, attrs) do
    contacts
    |> Contacts.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contacts.

  ## Examples

      iex> delete_contacts(contacts)
      {:ok, %Contacts{}}

      iex> delete_contacts(contacts)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contacts(%Contacts{} = contacts) do
    Repo.delete(contacts)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contacts changes.

  ## Examples

      iex> change_contacts(contacts)
      %Ecto.Changeset{source: %Contacts{}}

  """
  def change_contacts(%Contacts{} = contacts) do
    Contacts.changeset(contacts, %{})
  end

  # ----------------------------------------------------------------------------------Litigation

  alias Prolegals.Litigation.Cases

  @doc """
  Returns the list of li_tbl_case.

  ## Examples

      iex> list_li_tbl_case()
      [%Cases{}, ...]

  """
  def list_li_tbl_case do
    Repo.all(Cases)
  end

  @doc """
  Gets a single cases.

  Raises `Ecto.NoResultsError` if the Cases does not exist.

  ## Examples

      iex> get_cases!(123)
      %Cases{}

      iex> get_cases!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cases!(id), do: Repo.get!(Cases, id)

  @doc """
  Creates a cases.

  ## Examples

      iex> create_cases(%{field: value})
      {:ok, %Cases{}}

      iex> create_cases(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cases(attrs \\ %{}) do
    %Cases{}
    |> Cases.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cases.

  ## Examples

      iex> update_cases(cases, %{field: new_value})
      {:ok, %Cases{}}

      iex> update_cases(cases, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cases(%Cases{} = cases, attrs) do
    cases
    |> Cases.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cases.

  ## Examples

      iex> delete_cases(cases)
      {:ok, %Cases{}}

      iex> delete_cases(cases)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cases(%Cases{} = cases) do
    Repo.delete(cases)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cases changes.

  ## Examples

      iex> change_cases(cases)
      %Ecto.Changeset{source: %Cases{}}

  """
  def change_cases(%Cases{} = cases) do
    Cases.changeset(cases, %{})
  end
end
