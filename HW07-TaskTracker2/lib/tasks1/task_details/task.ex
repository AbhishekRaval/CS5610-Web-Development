defmodule Tasks1.TaskDetails.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.TaskDetails.Task
  alias Tasks1.TimeBlocks.Block


  schema "tasks" do
    field :complete, :boolean, default: false
    field :description, :string
    field :name, :string
    belongs_to :user, Tasks1.Account.User,  foreign_key: :user_id
    belongs_to :assigns, Tasks1.Account.User,  foreign_key: :assigns_id
    has_many :time_tracks, Block, foreign_key: :task_id
    has_many :timetracks ,through: [:time_tracks, :task]
    
    timestamps()
  end 

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :description, :complete, :user_id, :assigns_id])
    |> validate_required([:name, :description, :complete, :user_id])
  end
end
