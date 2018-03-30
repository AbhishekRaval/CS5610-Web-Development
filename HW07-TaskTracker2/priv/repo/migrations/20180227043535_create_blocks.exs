defmodule Tasks1.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :starts, :naive_datetime, null: false
      add :ends, :naive_datetime
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:blocks, [:task_id])
  end
end