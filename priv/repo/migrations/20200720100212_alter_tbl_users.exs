defmodule Prolegals.Repo.Migrations.AlterTblUsers do
  use Ecto.Migration

  def change do
    alter table(:tbl_users) do
      add :acc_inactive_reason, :string
      
    end

  end
end
