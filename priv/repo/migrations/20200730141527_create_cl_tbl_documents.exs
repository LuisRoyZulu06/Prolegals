defmodule Prolegals.Repo.Migrations.CreateClTblDocuments do
  use Ecto.Migration

  def change do
    create table(:cl_tbl_documents) do
      add :sender, :string
      add :description, :string
      add :document, :string
      add :mobile, :string
      add :document_filename, :string

      timestamps()
    end

  end
end
