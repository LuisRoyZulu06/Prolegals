defmodule Prolegals.Client.Messages do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cl_tbl_messages" do
    field :case_link, :string
    field :messages, :string
    field :recipient, :string
    field :sender, :string
    field :status, :string, default: "SENT"
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(messages, attrs) do
    messages
    |> cast(attrs, [:sender, :recipient, :messages, :status, :case_link, :subject])
    # |> validate_required([:sender, :recipient, :messages, :status, :case_link, :subject])
  end
end
