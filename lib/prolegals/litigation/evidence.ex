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

    timestamps()
  end

  @doc false
  def changeset(evidence, attrs) do
    evidence
    |> cast(attrs, [:evidence_type, :source, :description, :date_evidence_presented, :evidence_file])
    |> validate_required([:evidence_type, :source, :description, :date_evidence_presented, :evidence_file])
  end
end
