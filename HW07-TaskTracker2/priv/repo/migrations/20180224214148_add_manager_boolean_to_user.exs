defmodule Tasks1.Repo.Migrations.AddManagerBooleanToUser do
  use Ecto.Migration

  def change do
  	alter table(:users) do
	  add :managerstatus, :boolean, default: false, null: false
	end
  end
end
