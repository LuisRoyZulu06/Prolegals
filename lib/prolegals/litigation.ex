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

  # ----------------------------------------------------------------------------------Events
  alias Prolegals.Litigation.Events

  @doc """
  Returns the list of li_tbl_tasks.

  ## Examples

      iex> list_li_tbl_tasks()
      [%Events{}, ...]

  """
  def list_li_tbl_tasks do
    Repo.all(Events)
  end

  @doc """
  Gets a single events.

  Raises `Ecto.NoResultsError` if the Events does not exist.

  ## Examples

      iex> get_events!(123)
      %Events{}

      iex> get_events!(456)
      ** (Ecto.NoResultsError)

  """
  def get_events!(id), do: Repo.get!(Events, id)

  @doc """
  Creates a events.

  ## Examples

      iex> create_events(%{field: value})
      {:ok, %Events{}}

      iex> create_events(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events(attrs \\ %{}) do
    %Events{}
    |> Events.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a events.

  ## Examples

      iex> update_events(events, %{field: new_value})
      {:ok, %Events{}}

      iex> update_events(events, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events(%Events{} = events, attrs) do
    events
    |> Events.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a events.

  ## Examples

      iex> delete_events(events)
      {:ok, %Events{}}

      iex> delete_events(events)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events(%Events{} = events) do
    Repo.delete(events)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events changes.

  ## Examples

      iex> change_events(events)
      %Ecto.Changeset{source: %Events{}}

  """
  def change_events(%Events{} = events) do
    Events.changeset(events, %{})
  end


  # ----------------------------------------------------------------------------------Case Types

  alias Prolegals.Litigation.CaseType

  @doc """
  Returns the list of li_tbl_case_types.

  ## Examples

      iex> list_li_tbl_case_types()
      [%CaseType{}, ...]

  """
  def list_li_tbl_case_types do
    Repo.all(CaseType)
  end

  @doc """
  Gets a single case_type.

  Raises `Ecto.NoResultsError` if the Case type does not exist.

  ## Examples

      iex> get_case_type!(123)
      %CaseType{}

      iex> get_case_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_case_type!(id), do: Repo.get!(CaseType, id)

  @doc """
  Creates a case_type.

  ## Examples

      iex> create_case_type(%{field: value})
      {:ok, %CaseType{}}

      iex> create_case_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_case_type(attrs \\ %{}) do
    %CaseType{}
    |> CaseType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a case_type.

  ## Examples

      iex> update_case_type(case_type, %{field: new_value})
      {:ok, %CaseType{}}

      iex> update_case_type(case_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_case_type(%CaseType{} = case_type, attrs) do
    case_type
    |> CaseType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a case_type.

  ## Examples

      iex> delete_case_type(case_type)
      {:ok, %CaseType{}}

      iex> delete_case_type(case_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_case_type(%CaseType{} = case_type) do
    Repo.delete(case_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking case_type changes.

  ## Examples

      iex> change_case_type(case_type)
      %Ecto.Changeset{source: %CaseType{}}

  """
  def change_case_type(%CaseType{} = case_type) do
    CaseType.changeset(case_type, %{})
  end


  # ----------------------------------------------------------------------------------Business Category
  alias Prolegals.Litigation.BusinessCategory

  @doc """
  Returns the list of li_tbl_business_categories.

  ## Examples

      iex> list_li_tbl_business_categories()
      [%BusinessCategory{}, ...]

  """
  def list_li_tbl_business_categories do
    Repo.all(BusinessCategory)
  end

  @doc """
  Gets a single business_category.

  Raises `Ecto.NoResultsError` if the Business category does not exist.

  ## Examples

      iex> get_business_category!(123)
      %BusinessCategory{}

      iex> get_business_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business_category!(id), do: Repo.get!(BusinessCategory, id)

  @doc """
  Creates a business_category.

  ## Examples

      iex> create_business_category(%{field: value})
      {:ok, %BusinessCategory{}}

      iex> create_business_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business_category(attrs \\ %{}) do
    %BusinessCategory{}
    |> BusinessCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a business_category.

  ## Examples

      iex> update_business_category(business_category, %{field: new_value})
      {:ok, %BusinessCategory{}}

      iex> update_business_category(business_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business_category(%BusinessCategory{} = business_category, attrs) do
    business_category
    |> BusinessCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a business_category.

  ## Examples

      iex> delete_business_category(business_category)
      {:ok, %BusinessCategory{}}

      iex> delete_business_category(business_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business_category(%BusinessCategory{} = business_category) do
    Repo.delete(business_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business_category changes.

  ## Examples

      iex> change_business_category(business_category)
      %Ecto.Changeset{source: %BusinessCategory{}}

  """
  def change_business_category(%BusinessCategory{} = business_category) do
    BusinessCategory.changeset(business_category, %{})
  end

# ----------------------------------------------------------------------------------Evidence
  alias Prolegals.Litigation.Evidence

  @doc """
  Returns the list of li_tbl_evidence.

  ## Examples

      iex> list_li_tbl_evidence()
      [%Evidence{}, ...]

  """
  def list_li_tbl_evidence do
    Repo.all(Evidence)
  end

  @doc """
  Gets a single evidence.

  Raises `Ecto.NoResultsError` if the Evidence does not exist.

  ## Examples

      iex> get_evidence!(123)
      %Evidence{}

      iex> get_evidence!(456)
      ** (Ecto.NoResultsError)

  """
  def get_evidence!(id), do: Repo.get!(Evidence, id)


  def get_all_evidences(id) do
    Evidence
    |> where([e], e.case_id == ^id)
    |> Repo.all()
  end

  @doc """
  Creates a evidence.

  ## Examples

      iex> create_evidence(%{field: value})
      {:ok, %Evidence{}}

      iex> create_evidence(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_evidence(attrs \\ %{}) do
    %Evidence{}
    |> Evidence.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a evidence.

  ## Examples

      iex> update_evidence(evidence, %{field: new_value})
      {:ok, %Evidence{}}

      iex> update_evidence(evidence, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_evidence(%Evidence{} = evidence, attrs) do
    evidence
    |> Evidence.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a evidence.

  ## Examples

      iex> delete_evidence(evidence)
      {:ok, %Evidence{}}

      iex> delete_evidence(evidence)
      {:error, %Ecto.Changeset{}}

  """
  def delete_evidence(%Evidence{} = evidence) do
    Repo.delete(evidence)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking evidence changes.

  ## Examples

      iex> change_evidence(evidence)
      %Ecto.Changeset{source: %Evidence{}}

  """
  def change_evidence(%Evidence{} = evidence) do
    Evidence.changeset(evidence, %{})
  end
end
