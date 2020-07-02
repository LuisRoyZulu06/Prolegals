defmodule Prolegals.Repo.Migrations.CreateLiTblEvidence do
  use Ecto.Migration

  def change do
    create table(:li_tbl_evidence) do
      add :evidence_type, :string
      add :source, :string
      add :description, :string
      add :date_evidence_presented, :string
      add :evidence_file, :string

      timestamps()
    end

  end
end
