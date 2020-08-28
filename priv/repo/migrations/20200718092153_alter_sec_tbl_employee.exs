defmodule Prolegals.Repo.Migrations.AlterSecTblEmployee do
  use Ecto.Migration

  def change do
    alter table(:sec_tbl_employee) do
      add :employee_bulk_filename, :string
      
    end

  end
end
