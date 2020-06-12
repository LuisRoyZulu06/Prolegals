defmodule Prolegals.Repo.Migrations.CreateTblUsers do
  use Ecto.Migration

  def change do
    create table(:tbl_users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :password, :string
      add :user_type, :integer
      add :user_role, :string
      add :status, :integer
      add :auto_password, :string
      add :sex, :string
      add :age, :integer
      add :id_type, :string
      add :id_no, :integer
      add :phone, :integer
      add :home_add, :string
      add :user_id, :string

      timestamps()
    end
      create unique_index(:tbl_users, [:email], name: :unique_email)
  end
end
