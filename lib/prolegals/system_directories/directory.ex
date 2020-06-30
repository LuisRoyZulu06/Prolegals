defmodule Prolegals.SystemDirectories.Directory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_system_directories" do
    field :failed, :string
    field :processed, :string

    timestamps()
  end

  @doc false
  def changeset(directory, attrs) do
    directory
    |> cast(attrs, [:failed, :processed])
    |> validate_required([:failed, :processed])
  end
end
