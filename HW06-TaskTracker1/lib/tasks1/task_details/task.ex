defmodule Tasks1.TaskDetails.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.TaskDetails.Task


  schema "tasks" do
    field :complete, :boolean, default: false
    field :description, :string
    field :name, :string
    field :timespent, :time
    belongs_to :user, Tasks1.Account.User
    belongs_to :assigns, Tasks1.Account.User
    
    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :description, :complete, :timespent, :user_id, :assigns_id])
    |> validate_required([:name, :description, :complete, :timespent, :user_id, :assigns_id])
  end
end
