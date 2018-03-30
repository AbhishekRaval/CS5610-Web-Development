defmodule Tasks1.TaskDetailsTest do
  use Tasks1.DataCase

  alias Tasks1.TaskDetails

  describe "tasks" do
    alias Tasks1.TaskDetails.Task

    @valid_attrs %{complete: true, description: "some description", name: "some name", timespent: ~T[14:00:00.000000]}
    @update_attrs %{complete: false, description: "some updated description", name: "some updated name", timespent: ~T[15:01:01.000000]}
    @invalid_attrs %{complete: nil, description: nil, name: nil, timespent: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TaskDetails.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert TaskDetails.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskDetails.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = TaskDetails.create_task(@valid_attrs)
      assert task.complete == true
      assert task.description == "some description"
      assert task.name == "some name"
      assert task.timespent == ~T[14:00:00.000000]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskDetails.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = TaskDetails.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.complete == false
      assert task.description == "some updated description"
      assert task.name == "some updated name"
      assert task.timespent == ~T[15:01:01.000000]
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskDetails.update_task(task, @invalid_attrs)
      assert task == TaskDetails.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskDetails.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskDetails.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskDetails.change_task(task)
    end
  end
end
