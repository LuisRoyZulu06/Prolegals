defmodule Prolegals.Repo.Migrations.CreateSecTblVendor do
  use Ecto.Migration

  def change do
    create table(:sec_tbl_vendor) do
      add :vendor_name, :string
      add :address, :string
      add :contact, :string
      add :contact_person, :string
      add :country, :string
      add :email, :string

      timestamps()
    end

  end
end
