defmodule Tasks1.Repo.Migrations.AddUniqueUserKey do
  use Ecto.Migration

  def change do
  	create unique_index(:users, [:email])
  end
end
