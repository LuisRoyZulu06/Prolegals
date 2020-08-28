defmodule Prolegals.Client do
  @moduledoc """
  The Client context.
  """

  import Ecto.Query, warn: false
  alias Prolegals.Repo

  alias Prolegals.Client.Messages

  @doc """
  Returns the list of cl_tbl_messages.

  ## Examples

      iex> list_cl_tbl_messages()
      [%Messages{}, ...]

  """
  def list_cl_tbl_messages do
    Repo.all(Messages)
  end

  @doc """
  Gets a single messages.

  Raises `Ecto.NoResultsError` if the Messages does not exist.

  ## Examples

      iex> get_messages!(123)
      %Messages{}

      iex> get_messages!(456)
      ** (Ecto.NoResultsError)

  """
  def get_messages!(id), do: Repo.get!(Messages, id)

  @doc """
  Creates a messages.

  ## Examples

      iex> create_messages(%{field: value})
      {:ok, %Messages{}}

      iex> create_messages(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_messages(attrs \\ %{}) do
    %Messages{}
    |> Messages.changeset(attrs)
    |> Repo.insert()
  end

  # //////////////////////////////////// Status
  def get_send_message() do
    Repo.all(from t in Messages, where: [status: "SENT"])
  end

  @doc """
  Updates a messages.

  ## Examples

      iex> update_messages(messages, %{field: new_value})
      {:ok, %Messages{}}

      iex> update_messages(messages, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_messages(%Messages{} = messages, attrs) do
    messages
    |> Messages.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a messages.

  ## Examples

      iex> delete_messages(messages)
      {:ok, %Messages{}}

      iex> delete_messages(messages)
      {:error, %Ecto.Changeset{}}

  """
  def delete_messages(%Messages{} = messages) do
    Repo.delete(messages)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking messages changes.

  ## Examples

      iex> change_messages(messages)
      %Ecto.Changeset{source: %Messages{}}

  """
  def change_messages(%Messages{} = messages) do
    Messages.changeset(messages, %{})
  end

  # ---------------------------------------------------------------Get Client Notification to the lawyer
  def get_client_notification(email) do
    Repo.all(
      from(
        u in Messages,
        where: u.recipient == ^email and u.status == "sent",
        select: u
      )
    )
  end

  def get_inbox_notification(email) do
    Repo.all(
      from(
        u in Messages,
        where: u.recipient == ^email and u.user_role == "lawyer" and u.status == "sent",
        select: u
      )
    )
     
  end

  def get_client_sent_notification(email) do
    Repo.all(
      from(
        u in Messages,
        where: u.sender == ^email and u.user_role == "client",
        select: u
      )
    )
  end

  def get_client_trash_notification(email) do
    Repo.all(
      from(
        u in Messages,
        where: u.recipient == ^email and u.status == "trash",
        select: u
      )
    )
  end


  # -----------------------------------------------------------------------

  alias Prolegals.Client.Documents

  @doc """
  Returns the list of cl_tbl_documents.

  ## Examples

      iex> list_cl_tbl_documents()
      [%Documents{}, ...]

  """
  def list_cl_tbl_documents do
    Repo.all(Documents)
  end

  @doc """
  Gets a single documents.

  Raises `Ecto.NoResultsError` if the Documents does not exist.

  ## Examples

      iex> get_documents!(123)
      %Documents{}

      iex> get_documents!(456)
      ** (Ecto.NoResultsError)

  """
  def get_documents!(id), do: Repo.get!(Documents, id)

  @doc """
  Creates a documents.

  ## Examples

      iex> create_documents(%{field: value})
      {:ok, %Documents{}}

      iex> create_documents(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_documents(attrs \\ %{}) do
    %Documents{}
    |> Documents.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a documents.

  ## Examples

      iex> update_documents(documents, %{field: new_value})
      {:ok, %Documents{}}

      iex> update_documents(documents, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_documents(%Documents{} = documents, attrs) do
    documents
    |> Documents.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a documents.

  ## Examples

      iex> delete_documents(documents)
      {:ok, %Documents{}}

      iex> delete_documents(documents)
      {:error, %Ecto.Changeset{}}

  """
  def delete_documents(%Documents{} = documents) do
    Repo.delete(documents)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking documents changes.

  ## Examples

      iex> change_documents(documents)
      %Ecto.Changeset{source: %Documents{}}

  """
  def change_documents(%Documents{} = documents) do
    Documents.changeset(documents, %{})
  end
end
