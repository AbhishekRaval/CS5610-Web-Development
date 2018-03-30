defmodule Tasks1Web.BlockController do
  use Tasks1Web, :controller

  alias Tasks1.TimeBlocks
  alias Tasks1.TimeBlocks.Block

  action_fallback Tasks1Web.FallbackController

  def index(conn, _params) do
    blocks = TimeBlocks.list_blocks()
    render(conn, "index.json", blocks: blocks)
  end

  def newblock(conn,%{"id" => id}) do
    changeset = TimeBlocks.change_block(%Block{})
    task = Tasks1.TaskDetails.get_task!(id)
    render(conn, "new.html", changeset: changeset, task: task)
  end

  def create(conn, %{"block" => block_params}) do
    with {:ok, %Block{} = block} <- TimeBlocks.create_block(block_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", block_path(conn, :show, block))
      |> render("show.json", block: block)
    end
  end

  def add_timeblock(conn, %{"id" => id,"block" => block_params}) do
    task = Tasks1.TaskDetails.get_task!(id)
    case TimeBlocks.create_block(block_params) do
      {:ok, block} ->
        conn
        |> put_flash(:info, "Block created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, task: task)
    end
  end

  def edit(conn, %{"id" => id}) do
    block = TimeBlocks.get_block!(id)
    changeset = TimeBlocks.change_block(block)
    render(conn, "edit.html", block: block, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    block = TimeBlocks.get_block!(id)
    render(conn, "show.json", block: block)
  end

  def update(conn, %{"id" => id, "block" => block_params}) do
    block = TimeBlocks.get_block!(id)

    with {:ok, %Block{} = block} <- TimeBlocks.update_block(block, block_params) do
      render(conn, "show.json", block: block)
    end
  end

  def updatetimeblock(conn, %{"id" => id, "block" => block_params}) do
    block = TimeBlocks.get_block!(id)
    task = Tasks1.TaskDetails.get_task!(block_params["task_id"])
    case TimeBlocks.update_block(block, block_params) do
      {:ok, block} ->
        conn
        |> put_flash(:info, "Block updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", block: block, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    block = TimeBlocks.get_block!(id)
    with {:ok, %Block{}} <- TimeBlocks.delete_block(block) do
      send_resp(conn, :no_content, "")
    end
  end
end
