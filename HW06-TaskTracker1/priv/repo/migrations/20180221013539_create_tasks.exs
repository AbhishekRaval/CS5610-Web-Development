defmodule Tasks1.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string, null: false
      add :description, :text, null: false
      add :complete, :boolean, default: false
      add :timespent, :time
      add :user_id, references(:users, on_delete: :delete_all)
      add :assigns_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:tasks, [:user_id])
    create index(:tasks, [:assigns_id])
  end
end
