defmodule Prolegals.Repo.Migrations.CreateLiTblBusinessCategories do
  use Ecto.Migration

  def change do
    create table(:li_tbl_business_categories) do
      add :business_nature, :string
      add :business_type, :string

      timestamps()
    end

  end
end
