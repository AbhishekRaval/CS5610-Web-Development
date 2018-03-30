defmodule Tasks1.Repo.Migrations.RemoveTimespentColFromTasks do
  use Ecto.Migration

  def change do
  	alter table(:tasks) do
	  remove :timespent
	end
  end
end
