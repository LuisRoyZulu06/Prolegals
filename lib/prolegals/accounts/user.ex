defmodule Prolegals.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_users" do
    field :age, :integer
    field :auto_password, :string, default: "Y"
    field :email, :string
    field :first_name, :string
    field :home_add, :string
    field :id_no, :string
    field :id_type, :string
    field :last_name, :string
    field :password, :string
    field :phone, :string
    field :sex, :string
    field :status, :integer
    field :user_role, :string
    field :user_type, :integer
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :user_type, :user_role, :status, :auto_password, :sex, :age, :id_type, :id_no, :phone, :home_add, :user_id])
    |> validate_required([:first_name, :last_name, :email, :password, :user_type, :user_role, :status, :auto_password, :sex, :age, :id_type, :id_no, :phone, :home_add])
    |> validate_length(:password,
      min: 4,
      max: 40,
      message: " should be atleast 4 to 40 characters"
    )
    |> validate_length(:first_name,
      min: 2,
      max: 100,
      message: "should be between 3 to 100 characters"
    )
    |> validate_length(:last_name,
      min: 2,
      max: 100,
      message: "should be between 3 to 100 characters"
    )
    |> validate_length(:email,
      min: 10,
      max: 150,
      message: "Email Length should be between 10 to 150 characters"
    )
    |> unique_constraint(:email, name: :unique_email, message: " Email address already exists")
    |> unique_constraint(:phone, name: :unique_phone, message: " Phone number already exists")
    |> unique_constraint(:identity_number, name: :unique_identity_number, message: " ID number already exists")
    |> validate_user_role()
    |> put_pass_hash
  end

  defp validate_user_role(%Ecto.Changeset{valid?: true, changes: %{user_type: type, user_role: role}} = changeset) do
    case role == 1 && type == 2 do
      true ->
        add_error(changeset, :user, "under operations can't be admin")
      _->
        changeset
    end
  end

  defp validate_user_role(changeset), do: changeset

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    Ecto.Changeset.put_change(changeset, :password, encrypt_password(password))
  end

  defp put_pass_hash(changeset), do: changeset

  def encrypt_password(password), do: Base.encode16(:crypto.hash(:sha512, password))
end



#Prolegals.Accounts.create_user(%{first_name: "Luis Roy", last_name: "Zulu", email: "luis@probasegroup.com", password: "password06", user_type: 2, status: 1, user_role: "litigation", sex: "m", age: "24", id_type: "nrc", id_no: "342891/10/1", phone: "+260979797337", home_add: "202/20 Roma Null off Zambezi Road", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "John", last_name: "Mfula", email: "johnmfula360@gmail.com", password: "password02", user_type: 2, status: 1, user_role: "ligation", sex: "m", age: "29", id_type: "nrc", id_no: "304681/10/1", phone: +260975432237, home_add: "Mtendere A4443", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Lunje", last_name: "Daka", email: "lunje@probasegroup.com", password: "password04", user_type: 4, status: 1, user_role: "security", sex: "m", age: "29", id_type: "nrc", id_no: "2267891/10/1", phone: +260977009988, home_add: "Chawama", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})

#Prolegals.Accounts.create_user(%{first_name: "Luis Roy", last_name: "Zulu", email: "luis@probasegroup.com", password: "password06", user_type: 1, status: 1, user_role: "admin", sex: "m", age: "24", id_type: "nrc", id_no: "342891/10/1", phone: 0979797337, home_add: "202/20 Roma Null off Zambezi Road", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "John", last_name: "Mfula", email: "johnmfula360@gmail.com", password: "password02", user_type: 2, status: 1, user_role: "lawyer", sex: "m", age: "29", id_type: "nrc", id_no: "304681/10/1", phone: 0975432237, home_add: "Mtendere A4443", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Lunje", last_name: "Daka", email: "lunje@probasegroup.com", password: "password04", user_type: 4, status: 1, user_role: "security", sex: "m", age: "29", id_type: "nrc", id_no: "2267891/10/1", phone: 0977009988, home_add: "Chawama", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})

#Prolegals.Accounts.create_user(%{first_name: "Luis Roy", last_name: "Zulu", email: "luis@probasegroup.com", password: "password06", user_type: 1, status: 1, user_role: "admin", sex: "m", age: "24", id_type: "nrc", id_no: 342891101, phone: 0979797337, home_add: "202/20 Roma Null off Zambezi Road", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "john", last_name: "Mfula", email: "johnmfula@gmail.com", password: "password02", user_type: 2, status: 1, user_role: "lawyer", sex: "m", age: "24", id_type: "nrc", id_no: 304831101, phone: 0975432237, home_add: "mtendere A4443", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Davies", last_name: "Phiri", email: "davies@probasegroup.com", password: "password02", user_type: 1, status: 1, user_role: "admin", sex: "m", age: "24", id_type: "nrc", id_no: "304831/10/1", phone: 0978242442, home_add: "Foxdale off Zambezi road", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "john", last_name: "Mfula", email: "security@gmail.com", password: "cool", user_type: 4, status: 1, user_role: "security", sex: "m", age: "24", id_type: "nrc", id_no: 30468101, phone: 0975432267, home_add: "mtendere A4555", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})

#Prolegals.Accounts.create_user(%{first_name: "Luis Roy", last_name: "Zulu", email: "luis@probasegroup.com", password: "password06", user_type: 1, status: 1, user_role: "admin", sex: "m", age: "24", id_type: "nrc", id_no: "342891/10/1", phone: 0979797337, home_add: "202/20 Roma Null off Zambezi Road", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "John", last_name: "Mfula", email: "johnmfula360@gmail.com", password: "password02", user_type: 2, status: 1, user_role: "lawyer", sex: "m", age: "29", id_type: "nrc", id_no: "304681/10/1", phone: 0975432237, home_add: "Mtendere A4443", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Lunje", last_name: "Daka", email: "lunje@probasegroup.com", password: "password04", user_type: 4, status: 1, user_role: "security", sex: "m", age: "29", id_type: "nrc", id_no: "2267891/10/1", phone: 0977009988, home_add: "Chawama", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})


