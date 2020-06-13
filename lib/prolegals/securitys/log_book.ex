defmodule Prolegals.Securitys.Log_book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_log_book" do
    field :address, :string
    field :company, :string
    field :date, :string
    field :id_no, :string
    field :id_type, :string
    field :image, :string
    field :mobile_no, :string
    field :name, :string
    field :person_to_see, :string
    field :purpose, :string
    field :sex, :string
    field :time_in, :string
    field :time_out, :string

    timestamps()
  end

  @doc false
  def changeset(log_book, attrs) do
    log_book
    |> cast(attrs, [:name, :sex, :id_type, :id_no, :image, :mobile_no, :address, :company, :person_to_see, :purpose, :date, :time_in, :time_out])
    # |> validate_required([:name, :sex, :id_type, :id_no, :image, :mobile_no, :address, :company, :person_to_see, :purpose, :date, :time_in, :time_out])
  end
end
