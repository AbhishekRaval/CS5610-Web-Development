defmodule Tasks1Web.BlockControllerTest do
  use Tasks1Web.ConnCase

  alias Tasks1.TimeBlocks
  alias Tasks1.TimeBlocks.Block

  @create_attrs %{ends: ~N[2010-04-17 14:00:00.000000], starts: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{ends: ~N[2011-05-18 15:01:01.000000], starts: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{ends: nil, starts: nil}

  def fixture(:block) do
    {:ok, block} = TimeBlocks.create_block(@create_attrs)
    block
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all blocks", %{conn: conn} do
      conn = get conn, block_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create block" do
    test "renders block when data is valid", %{conn: conn} do
      conn = post conn, block_path(conn, :create), block: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, block_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ends" => ~N[2010-04-17 14:00:00.000000],
        "starts" => ~N[2010-04-17 14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, block_path(conn, :create), block: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update block" do
    setup [:create_block]

    test "renders block when data is valid", %{conn: conn, block: %Block{id: id} = block} do
      conn = put conn, block_path(conn, :update, block), block: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, block_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "ends" => ~N[2011-05-18 15:01:01.000000],
        "starts" => ~N[2011-05-18 15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, block: block} do
      conn = put conn, block_path(conn, :update, block), block: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete block" do
    setup [:create_block]

    test "deletes chosen block", %{conn: conn, block: block} do
      conn = delete conn, block_path(conn, :delete, block)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, block_path(conn, :show, block)
      end
    end
  end

  defp create_block(_) do
    block = fixture(:block)
    {:ok, block: block}
  end
end
