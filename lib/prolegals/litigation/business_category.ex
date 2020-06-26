defmodule Prolegals.Litigation.BusinessCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "li_tbl_business_categories" do
    field :business_nature, :string
    field :business_type, :string

    timestamps()
  end

  @doc false
  def changeset(business_category, attrs) do
    business_category
    |> cast(attrs, [:business_nature, :business_type])
    |> validate_required([:business_nature, :business_type])
  end
end
