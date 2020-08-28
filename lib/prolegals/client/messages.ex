defmodule Prolegals.Client.Messages do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cl_tbl_messages" do
    field :case_link, :string
    field :messages, :string
    field :recipient, :string
    field :sender, :string
    field :status, :string, default: "sent"
    field :subject, :string
    field :user_role, :string

    timestamps()
  end

  @doc false
  def changeset(messages, attrs) do
    messages
    |> cast(attrs, [:sender, :user_role, :recipient, :messages, :status, :case_link, :subject])
    |> validate_required([:sender, :recipient, :messages, :subject])
    |> validate_length(:messages, min: 3, max: 255, message: "Can not insert too many texts")
  end
end
