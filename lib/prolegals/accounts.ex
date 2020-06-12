defmodule Prolegals.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Prolegals.Repo

  alias Prolegals.Accounts.User

  @doc """
  Returns the list of tbl_users.

  ## Examples

      iex> list_tbl_users()
      [%User{}, ...]

  """
  def list_tbl_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # -------------------TEST------------------------------
  def get_user_by(nt_username) do
    Repo.all(
      from(
        u in User,
        where: fragment("lower(?) = lower(?)", u.nt_username, ^nt_username),
        limit: 1,
        select: u
      )
    )
  end

  def get_all_super_admins do
    Repo.all(
      from(
        u in User,
        where: u.user_role == 1,
        select: u
      )
    )
  end

  def get_all_users do
    Repo.all(
      from u in User,
        preload: [:user],
        select:
          map(
            u,
            [
              :id,
              :user_id,
              :inserted_at,
              :inserted_at,
              :updated_at,
              :first_name,
              :last_name,             
              :email,
              :department_id,
              :status,            
              :user_type,
              :user_role,
              user: [:first_name, :last_name]
            ]
          )
    )
  end
  # -----------------------------------------------------
end
