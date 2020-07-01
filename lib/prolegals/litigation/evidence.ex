defmodule Prolegals.Litigation.Evidence do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "li_tbl_evidence" do
    field :date_evidence_presented, :string
    field :description, :string
    field :evidence_file, Prolegals.ImageUploader.Type
    field :evidence_type, :string
    field :source, :string
    # field :case_id, :string

    belongs_to :cases, Prolegals.Litigation.Cases, foreign_key: :case_id, type: :id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(evidence, attrs) do
    evidence
    |> cast(attrs, [:evidence_type, :source, :description, :date_evidence_presented, :evidence_file, :case_id])
    |> validate_required([:evidence_type, :source, :description, :date_evidence_presented, :evidence_file, :case_id])
  end
end
