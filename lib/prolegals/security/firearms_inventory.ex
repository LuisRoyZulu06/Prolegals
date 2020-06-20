defmodule Prolegals.Security.FirearmsInventory do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema

  schema "sec_tbl_firearms" do
    field :brand, :string
    field :bullet_id, :string
    field :date_purchased, :string
    field :firearm_image, Prolegals.ImageUploader.Type
    field :make_year, :string
    field :model, :string
    field :name, :string
    field :person_assigned, :string
    field :purchase_price, :string
    field :purchased_from, :string
    field :rounds, :string
    field :serial_number, :string
    field :status, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(firearms_inventory, attrs) do
    firearms_inventory
    |> cast(attrs, [:firearm_image])
    |> cast_attachments(attrs, [:firearm_image])
    |> cast(attrs, [:name, :type, :brand, :model, :serial_number, :rounds, :date_purchased, :purchased_from, :purchase_price, :make_year, :person_assigned, :status, :bullet_id, :firearm_image])
    # |> validate_required([:name, :type, :brand, :model, :serial_number, :rounds, :date_purchased, :purchased_from, :purchase_price, :make_year, :person_assigned, :status, :bullet_id, :firearm_image])

  end
end
