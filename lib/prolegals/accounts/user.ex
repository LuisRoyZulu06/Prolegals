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

  @spec encrypt_password(binary | maybe_improper_list(binary | maybe_improper_list(any, binary | []) | byte, binary | [])) :: binary
  def encrypt_password(password), do: Base.encode16(:crypto.hash(:sha512, password))
end

#Prolegals.Accounts.create_user(%{first_name: "John", last_name: "Mfula", email: "johnmfula360@gmail.com", password: "cool", user_type: 1, status: 1, user_role: "admin", sex: "m", age: "29", id_type: "nrc", id_no: "304421/10/1", phone: "+260974436237", home_add: "Mtendere A4453", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Joseph", last_name: "Banda", email: "lawyer3@gmail.com", password: "cool", user_type: 2, status: 1, user_role: "litigation", sex: "m", age: "25", id_type: "nrc", id_no: "301381/10/1", phone: "+260975423547", home_add: "Mtendere B5946", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Lunje", last_name: "Daka", email: "security@gmail.com", password: "cool", user_type: 4, status: 1, user_role: "security", sex: "m", age: "23", id_type: "nrc", id_no: "2267891/10/1", phone: "+260977009988", home_add: "Chawama", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Lunje", last_name: "Daka", email: "client@gmail.com", password: "cool", user_type: 3, status: 1, user_role: "client", sex: "m", age: "23", id_type: "nrc", id_no: "22891/10/1", phone: "+260977009988", home_add: "Chawama", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})

#Prolegals.Accounts.create_user(%{first_name: "Luis Roy", last_name: "Zulu", email: "luis@probasegroup.com", password: "password06", user_type: 2, status: 1, user_role: "litigation", sex: "m", age: "24", id_type: "nrc", id_no: "342891/10/1", phone: "+260979797337", home_add: "202/20 Roma Null off Zambezi Road", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Lunje", last_name: "Daka", email: "security@gmail.com", password: "cool", user_type: 4, status: 1, user_role: "security", sex: "m", age: "23", id_type: "nrc", id_no: "2267891/10/1", phone: "+260977009988", home_add: "Chawama", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
#Prolegals.Accounts.create_user(%{first_name: "Davies", last_name: "Phiri", email: "davies@probasegroup.com", password: "password01", user_type: 1, status: 1, user_role: "admin", sex: "m", age: "23", id_type: "nrc", id_no: "789123/10/1", phone: "+260978242442", home_add: "New Ngombe", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})


