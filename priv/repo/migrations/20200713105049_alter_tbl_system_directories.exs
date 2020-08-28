defmodule Prolegals.Repo.Migrations.AlterTblSystemDirectories do
  use Ecto.Migration

  def change do
    alter table(:tbl_system_directories) do
      add :facial_image, :string
      
    end
  end
end
