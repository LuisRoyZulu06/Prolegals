defmodule Prolegals.Litigation.Cases do
  use Ecto.Schema
  import Ecto.Changeset

  schema "li_tbl_case" do
    field :case_description, :string
    field :case_name, :string
    field :case_no, :string
    field :case_status, :string
    field :client, :string
    field :date_case_opened, :string
    field :incident_date, :string
    field :practice_area, :string
    field :staff, :string
    field :case_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cases, attrs) do
    cases
    |> cast(attrs, [:case_name, :case_no, :case_status, :practice_area, :case_description, :client, :staff, :incident_date, :date_case_opened, :case_id])
    |> validate_required([:case_name, :case_no, :case_status, :practice_area, :case_description, :client, :staff, :incident_date, :date_case_opened])
  end
end
