defmodule Prolegals.Repo.Migrations.CreateSecTblInventoryCategories do
  use Ecto.Migration

  def change do
    create table(:sec_tbl_inventory_categories) do
      add :name, :string
      add :category_code, :string
      add :asset_id, :string
      add :category_id, :string

      timestamps()
    end

  end
end
