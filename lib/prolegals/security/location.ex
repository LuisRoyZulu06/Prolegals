defmodule Prolegals.Security.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sec_tbl_location" do
    field :address, :string
    field :contact, :string
    field :contact_person, :string
    field :email, :string
    field :office_name, :string
    field :province, :string

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:office_name, :address, :contact, :contact_person, :province, :email])
    |> validate_required([:office_name, :address, :contact, :contact_person, :province, :email])
  end
end
