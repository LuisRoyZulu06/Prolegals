defmodule Prolegals.Repo.Migrations.CreateSecTblFirearms do
  use Ecto.Migration

  def change do
    create table(:sec_tbl_firearms) do
      add :name, :string
      add :type, :string
      add :brand, :string
      add :model, :string
      add :serial_number, :string
      add :rounds, :string
      add :date_purchased, :string
      add :purchased_from, :string
      add :purchase_price, :string
      add :make_year, :string
      add :person_assigned, :string
      add :status, :string
      add :bullet_id, :string
      add :firearm_image, :string

      timestamps()
    end

  end
end
