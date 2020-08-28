defmodule Prolegals.Client.Documents do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cl_tbl_documents" do
    field :description, :string
    field :document, :string
    field :document_filename, :string
    field :mobile, :string
    field :sender, :string

    timestamps()
  end

  @doc false
  def changeset(documents, attrs) do
    documents
    |> cast(attrs, [:sender, :description, :document, :mobile, :document_filename])
    # |> validate_required([:sender, :description, :document, :mobile, :document_filename])
  end
end
