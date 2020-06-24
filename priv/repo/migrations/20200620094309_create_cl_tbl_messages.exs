defmodule Prolegals.Repo.Migrations.CreateClTblMessages do
  use Ecto.Migration

  def change do
    create table(:cl_tbl_messages) do
      add :sender, :string
      add :recipient, :string
      add :messages, :string
      add :status, :string
      add :case_link, :string
      add :subject, :string

      timestamps()
    end

  end
end
