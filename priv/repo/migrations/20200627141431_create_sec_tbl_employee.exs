defmodule Prolegals.Repo.Migrations.CreateSecTblEmployee do
  use Ecto.Migration

  def change do
    create table(:sec_tbl_employee) do
      add :employee_name, :string
      add :employee_no, :string
      add :contact, :string
      add :email, :string
      add :department, :string
      add :nrc, :string

      timestamps()
    end

  end
end
