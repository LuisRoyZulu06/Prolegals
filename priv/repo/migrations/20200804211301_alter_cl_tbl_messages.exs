defmodule Prolegals.Repo.Migrations.AlterClTblMessages do
  use Ecto.Migration

  def change do
    alter table(:cl_tbl_messages) do
      add :user_role, :string
      
    end

  end
end
