defmodule Prolegals.Repo.Migrations.CreateSecTblLogBook do
  use Ecto.Migration

  def change do
    create table(:sec_tbl_log_book) do
      add :name, :string
      add :sex, :string
      add :id_type, :string
      add :id_no, :string
      add :image, :string
      add :mobile_no, :string
      add :address, :string
      add :company, :string
      add :person_to_see, :string
      add :purpose, :string
      add :date, :string
      add :time_in, :string
      add :time_out, :string

      timestamps()
    end

  end
end
