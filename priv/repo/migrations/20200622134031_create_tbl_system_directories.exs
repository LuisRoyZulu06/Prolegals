defmodule Prolegals.Repo.Migrations.CreateTblSystemDirectories do
  use Ecto.Migration

  def change do
    create table(:tbl_system_directories) do
      add :failed, :string
      add :processed, :string

      timestamps()
    end

  end
end
