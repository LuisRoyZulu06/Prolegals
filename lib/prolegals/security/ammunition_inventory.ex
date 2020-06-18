defmodule Prolegals.Security.AmmunitionInventory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sec_tbl_ammunition" do
    field :caliber, :string
    field :firearm_serial_number, :string
    field :quantity, :string
    field :serial_number, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(ammunition_inventory, attrs) do
    ammunition_inventory
    |> cast(attrs, [:caliber, :serial_number, :type, :quantity, :firearm_serial_number])
    |> validate_required([:caliber, :serial_number, :type, :quantity, :firearm_serial_number])
  end
end
