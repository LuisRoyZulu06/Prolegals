defmodule Prolegals.Repo.Migrations.CreateLiTblTasks do
  use Ecto.Migration

  def change do
    create table(:li_tbl_tasks) do
      add :case, :string
      add :start_date, :string
      add :start_time, :string
      add :end_date, :string
      add :end_time, :string
      add :location, :string
      add :details, :string
      add :visibility, :string
      add :event_name, :string
      add :priority, :string
      add :status, :string

      timestamps()
    end

  end
end
