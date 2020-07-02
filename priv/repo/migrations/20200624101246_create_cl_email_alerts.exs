defmodule Prolegals.Repo.Migrations.CreateClEmailAlerts do
  use Ecto.Migration

  def change do
    create table(:tbl_email_alerts) do
      add :type, :string,size: 20
      add :email, :string, size: 100
      add :user_id, references(:tbl_users, column: :id, on_delete: :nilify_all)

      timestamps()
    end

    create unique_index(:tbl_email_alerts, [:email, :type])
  end

end
