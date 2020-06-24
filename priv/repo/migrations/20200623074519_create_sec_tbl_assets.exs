defmodule Prolegals.Repo.Migrations.CreateSecTblAssets do
  use Ecto.Migration

  def change do
    create table(:sec_tbl_assets) do
      add :name, :string
      add :brand, :string
      add :category_id, :string
      add :type, :string
      add :quantity, :string
      add :serial_number, :string
      add :status, :string
      add :date_purchased, :string
      add :purchased_from, :string
      add :make_year, :string

      timestamps()
    end

  end
end
