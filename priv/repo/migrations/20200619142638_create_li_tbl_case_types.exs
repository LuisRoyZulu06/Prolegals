defmodule Prolegals.Repo.Migrations.CreateLiTblCaseTypes do
  use Ecto.Migration

  def change do
    create table(:li_tbl_case_types) do
      add :category, :string
      add :description, :string

      timestamps()
    end

  end
end
