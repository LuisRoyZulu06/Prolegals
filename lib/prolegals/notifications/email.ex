defmodule Prolegals.Notifications.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_email_alerts" do
    field :email, :string
    field :type, :string

    belongs_to :user, Prolegals.Accounts.User, foreign_key: :user_id, type: :id

    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:type, :email])
    |> validate_required([:type, :email])
    |> validate_length(:type,
      min: 3,
      max: 20,
      message: "should be between 3 to 20 characters"
    )
    |> validate_length(:email,
      min: 10,
      max: 100,
      message: "should be between 10 to 100 characters"
    )
    |> unique_constraint(:email,
      name: :unique_email,
      message: " for this type already exists"
    )
  end
end
# Prolegals.Notifications.create_email(%{email: "Coilardium@gmail.com", type: "", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
