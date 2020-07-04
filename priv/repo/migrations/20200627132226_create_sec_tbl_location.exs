defmodule Prolegals.Repo.Migrations.CreateSecTblLocation do
  use Ecto.Migration

  def change do
    create table(:sec_tbl_location) do
      add :office_name, :string
      add :address, :string
      add :contact, :string
      add :contact_person, :string
      add :province, :string
      add :email, :string

      timestamps()
    end

  end
end
