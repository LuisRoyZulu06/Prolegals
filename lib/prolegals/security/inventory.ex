defmodule Prolegals.Security.Inventory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sec_tbl_inventory_categories" do
    field :category_code, :string
    field :name, :string
    field :asset_id, :string
    field :category_id, :string

    timestamps()
  end

  @doc false
  def changeset(inventory, attrs) do
    inventory
    |> cast(attrs, [:name, :category_code, :asset_id])
    |> validate_required([:name, :category_code])
  end
end
