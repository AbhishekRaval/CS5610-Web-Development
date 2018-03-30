defmodule Tasks1.TimeBlocksTest do
  use Tasks1.DataCase

  alias Tasks1.TimeBlocks

  describe "blocks" do
    alias Tasks1.TimeBlocks.Block

    @valid_attrs %{"": ~N[2010-04-17 14:00:00.000000], ends: "some ends", starts: "some starts"}
    @update_attrs %{"": ~N[2011-05-18 15:01:01.000000], ends: "some updated ends", starts: "some updated starts"}
    @invalid_attrs %{"": nil, ends: nil, starts: nil}

    def block_fixture(attrs \\ %{}) do
      {:ok, block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TimeBlocks.create_block()

      block
    end

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert TimeBlocks.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert TimeBlocks.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      assert {:ok, %Block{} = block} = TimeBlocks.create_block(@valid_attrs)
      assert block. == ~N[2010-04-17 14:00:00.000000]
      assert block.ends == "some ends"
      assert block.starts == "some starts"
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeBlocks.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()
      assert {:ok, block} = TimeBlocks.update_block(block, @update_attrs)
      assert %Block{} = block
      assert block. == ~N[2011-05-18 15:01:01.000000]
      assert block.ends == "some updated ends"
      assert block.starts == "some updated starts"
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeBlocks.update_block(block, @invalid_attrs)
      assert block == TimeBlocks.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = TimeBlocks.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> TimeBlocks.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = TimeBlocks.change_block(block)
    end
  end
end
