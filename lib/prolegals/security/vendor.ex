defmodule Prolegals.Security.Vendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sec_tbl_vendor" do
    field :address, :string
    field :contact, :string
    field :contact_person, :string
    field :country, :string
    field :email, :string
    field :vendor_name, :string

    timestamps()
  end

  @doc false
  def changeset(vendor, attrs) do
    vendor
    |> cast(attrs, [:vendor_name, :address, :contact, :contact_person, :country, :email])
    |> validate_required([:vendor_name, :address, :contact, :contact_person, :country, :email])
  end
end
