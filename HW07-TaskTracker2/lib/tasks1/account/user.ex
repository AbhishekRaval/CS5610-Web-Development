defmodule Tasks1.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.Account.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :managerstatus, :boolean
    belongs_to :manager, Tasks1.Account.User,  foreign_key: :manager_id
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :managerstatus, :manager_id])
    |> unique_constraint(:email)
    |> validate_required([:email, :name, :managerstatus])
  end
end
