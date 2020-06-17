defmodule Prolegals.Repo.Migrations.CreateLiTblContacts do
  use Ecto.Migration

  def change do
    create table(:li_tbl_contacts) do
      add :name, :string
      add :email, :string
      add :phone, :string
      add :company_name, :string
      add :job_title, :string
      add :id_type, :string
      add :id_no, :string
      add :company_rep, :string
      add :bus_category, :string
      add :contact_type, :string
      add :fax, :string
      add :tel, :string
      add :city, :string
      add :country, :string
      add :home_add, :string
      add :comp_email, :string
      add :comp_address, :string

      timestamps()
    end

  end
end
