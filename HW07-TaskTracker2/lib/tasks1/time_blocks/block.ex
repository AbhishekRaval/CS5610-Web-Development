defmodule Tasks1.TimeBlocks.Block do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.TimeBlocks.Block


  schema "blocks" do
    field :ends, :naive_datetime
    field :starts, :naive_datetime, default: nil
    belongs_to :task, Tasks1.TaskDetails.Task
    timestamps()
  end

  @doc false
  def changeset(%Block{} = block, attrs) do
    block
    |> cast(attrs, [:starts, :ends, :task_id])
    |> validate_required([:starts, :ends, :task_id])
  end
end
