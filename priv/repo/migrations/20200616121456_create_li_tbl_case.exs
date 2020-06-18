defmodule Prolegals.Repo.Migrations.CreateLiTblCase do
  use Ecto.Migration

  def change do
    create table(:li_tbl_case) do
      add :case_name, :string
      add :case_no, :string
      add :case_status, :string
      add :practice_area, :string
      add :case_description, :string
      add :client, :string
      add :staff, :string
      add :incident_date, :string
      add :date_case_opened, :string

      timestamps()
    end

  end
end
