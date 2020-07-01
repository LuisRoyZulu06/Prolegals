defmodule Prolegals.Litigation.CaseType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "li_tbl_case_types" do
    field :category, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(case_type, attrs) do
    case_type
    |> cast(attrs, [:category, :description])
    |> validate_required([:category, :description])
  end
end
