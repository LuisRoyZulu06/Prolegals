defmodule Prolegals.Security.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sec_tbl_assets" do
    field :brand, :string
    field :category_id, :string
    field :date_purchased, :string
    field :make_year, :string
    field :name, :string
    field :purchased_from, :string
    field :quantity, :string
    field :serial_number, :string
    field :status, :string
    field :type, :string
    # field :asset_id, :string

    belongs_to :asset, Prolegals.Security.Inventory, foreign_key: :asset_id, type: :id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:name, :brand, :category_id, :type, :quantity, :serial_number, :status, :date_purchased, :purchased_from, :make_year])
    |> validate_required([:name, :brand, :category_id, :type, :quantity, :serial_number, :status, :date_purchased, :purchased_from, :make_year])
  end
end
