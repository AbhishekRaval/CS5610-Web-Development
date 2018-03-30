defmodule Tasks1Web.TaskController do
use Tasks1Web, :controller

alias Tasks1.TaskDetails
alias Tasks1.TaskDetails.Task

def index(conn, _params) do
  tasks = TaskDetails.list_tasks()
  render(conn, "index.html", tasks: tasks)
end

def new(conn, _params) do
  users = Tasks1.Account.list_users()
  changeset = TaskDetails.change_task(%Task{})
  render(conn, "new.html", changeset: changeset, users: users)
end

def create(conn, %{"task" => task_params}) do
  time = task_params["timespent"]
  {h,_} = Integer.parse(time["hour"])
  {m,_} = Integer.parse(time["minute"])
  totaltime = h*60 + m
  if (totaltime >= 15 || m==0) && (rem totaltime,15) == 0 do
   case TaskDetails.create_task(task_params) do 
    {:ok, post} ->
      conn
      |> put_flash(:info, "Task created successfully.")
      |> redirect(to: "/feed")
      {:error, %Ecto.Changeset{} = changeset} ->
        users = Tasks1.Account.list_users()
        render(conn, "new.html", changeset: changeset, users: users)
      end
    else
      changeset = Tasks1.TaskDetails.change_task(%Task{})
      users = Tasks1.Account.list_users()
      conn
      |> put_flash(:error, "Select Time Spent in 15 minutes Timer Interval.")
      |> render("new.html", users: users, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = TaskDetails.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = TaskDetails.get_task!(id)
    changeset = TaskDetails.change_task(task)
    users = Tasks1.Account.list_users()
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = TaskDetails.get_task!(id)
    time = task_params["timespent"]
    {h,_} = Integer.parse(time["hour"])
    {m,_} = Integer.parse(time["minute"])
    totaltime = h*60 + m
    if (totaltime >= 15 || m==0) && (rem totaltime,15) == 0 do
      case TaskDetails.update_task(task, task_params) do 
        {:ok, post} ->
          conn
          |> put_flash(:info, "Task updated successfully.")
          |> redirect(to: "/feed")
          {:error, %Ecto.Changeset{} = changeset} ->
            users = Tasks1.Account.list_users()
            render("edit.html", task: task, changeset: changeset, users: users)
          end
        else
          changeset = Tasks1.TaskDetails.change_task(task)
          users = Tasks1.Account.list_users()
          conn
          |> put_flash(:error, "Select Time Spent in 15 minutes Timer Interval.")
          |> render("edit.html", task: task, changeset: changeset, users: users)
        end
      end

      def delete(conn, %{"id" => id}) do
        task = TaskDetails.get_task!(id)
        {:ok, _task} = TaskDetails.delete_task(task)

        conn
        |> put_flash(:info, "Task deleted successfully.")
        |> redirect(to: "/feed")
      end
    end
