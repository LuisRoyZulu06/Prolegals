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
    field :serial_number, :string
    field :status, :string
    field :type, :string
    field :purchase_price, :string
    field :asset_number, :string
    field :employee_number, :string
    field :office_location, :string
    field :assaigned, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:name, :brand, :category_id, :type, :serial_number, :status, :date_purchased, :purchased_from, :make_year, :purchase_price, :asset_number, :employee_number, :office_location, :assaigned])
    |> validate_required([:name, :brand, :category_id, :type, :serial_number, :status, :date_purchased, :purchased_from, :make_year])
  end
end
