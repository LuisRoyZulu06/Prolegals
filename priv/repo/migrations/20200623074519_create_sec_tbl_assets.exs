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
      add :asset_id, references(:sec_tbl_inventory_categories, column: :id, on_delete: :delete_all)

      timestamps()
    end

  end
end
