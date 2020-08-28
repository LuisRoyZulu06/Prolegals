defmodule Prolegals.Security.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sec_tbl_employee" do
    field :contact, :string
    field :department, :string
    field :email, :string
    field :employee_name, :string
    field :employee_no, :string
    field :nrc, :string
    field :employee_bulk_filename, :string

    # belongs_to :user, Prolegals.Accounts.User, foreign_key: :user_id, type: :id

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:employee_name, :employee_no, :contact, :email, :department, :nrc])
    |> validate_required([:employee_name, :employee_no, :contact, :email, :department, :nrc])
  end
end