defmodule Prolegals.Litigation.Events do
  use Ecto.Schema
  import Ecto.Changeset

  schema "li_tbl_tasks" do
    field :case, :string
    field :details, :string
    field :end_date, :string
    field :end_time, :string
    field :location, :string
    field :start_date, :string
    field :start_time, :string
    field :visibility, :string, default: "Public"
    field :event_name, :string
    field :priority, :string
    field :status, :string, default: "Pending"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(events, attrs) do
    events
    |> cast(attrs, [:case, :start_date, :start_time, :end_date, :end_time, :location, :details, :visibility, :event_name, :priority, :status])
    |> validate_required([:case, :start_date, :start_time, :end_date, :end_time, :location, :details, :visibility, :event_name, :priority, :status])
  end
end
