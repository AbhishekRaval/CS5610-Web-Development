defmodule Tasks1Web.BlockView do
  use Tasks1Web, :view
  alias Tasks1Web.BlockView

  def render("index.json", %{blocks: blocks}) do
    %{data: render_many(blocks, BlockView, "block.json")}
  end

  def render("show.json", %{block: block}) do
    %{data: render_one(block, BlockView, "block.json")}
  end

  def render("block.json", %{block: block}) do
    %{id: block.id,
      starts: block.starts,
      ends: block.ends}
  end
end
