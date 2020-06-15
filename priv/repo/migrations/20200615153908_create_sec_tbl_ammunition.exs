defmodule Prolegals.Repo.Migrations.CreateSecTblAmmunition do
  use Ecto.Migration

  def change do
    create table(:sec_tbl_ammunition) do
      add :caliber, :string
      add :serial_number, :string
      add :type, :string
      add :quantity, :string
      add :firearm_serial_number, :string

      timestamps()
    end

  end
end
