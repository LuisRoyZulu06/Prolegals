defmodule Prolegals.Security.Inventory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sec_tbl_inventory_categories" do
    field :category_code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(inventory, attrs) do
    inventory
    |> cast(attrs, [:name, :category_code])
    |> validate_required([:name, :category_code])
  end
end
