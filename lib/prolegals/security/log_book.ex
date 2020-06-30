defmodule Prolegals.Security.LogBook do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query, only: [from: 2]

  @timestamps_opts [type: Timex.Ecto.TimestampWithTimezone,
  autogenerate: {Timex.Ecto.TimestampWithTimezone, :autogenerate, []}]

  schema "sec_tbl_log_book" do
    field :address, :string
    field :company, :string
    field :date, :string
    field :id_no, :string
    field :id_type, :string
    field :image, Prolegals.ImageUploader.Type
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
    |> validate_required([:name, :sex, :id_type, :id_no, :mobile_no, :address, :company, :person_to_see, :purpose])
    # |> unique_constraint(:id_no)
  end

  def search(query, search_term)do
    wildcard_search = "%#{search_term}%"

    from log_book in query,
    where: ilike(log_book.name, ^wildcard_search),
    or_where: ilike(log_book.id_no, ^wildcard_search)

   end

end
