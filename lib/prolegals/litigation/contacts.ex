defmodule Prolegals.Litigation.Contacts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "li_tbl_contacts" do
    field :bus_category, :string
    field :city, :string
    field :company_name, :string
    field :compnay_rep, :string
    field :contact_type, :string
    field :country, :string
    field :email, :string
    field :fax, :string
    field :id_no, :string
    field :id_type, :string
    field :job_title, :string
    field :name, :string
    field :phone, :string
    field :tel, :string

    timestamps()
  end

  @doc false
  def changeset(contacts, attrs) do
    contacts
    |> cast(attrs, [:name, :email, :phone, :company_name, :job_title, :id_type, :id_no, :compnay_rep, :bus_category, :contact_type, :fax, :tel, :city, :country])
    # |> validate_required([:name, :email, :phone, :company_name, :job_title, :id_type, :id_no, :compnay_rep, :bus_category, :contact_type, :fax, :tel, :city, :country])
  end
end
