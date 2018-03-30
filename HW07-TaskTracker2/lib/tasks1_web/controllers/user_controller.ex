defmodule Tasks1Web.UserController do
  use Tasks1Web, :controller

  alias Tasks1.Account
  alias Tasks1.Account.User

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Account.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def newmanager(conn, _params) do
    changeset = Account.change_user(%User{})
    render(conn, "new2.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Account.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: "/feed")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do    
    user = Account.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    changeset = Account.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)
    case Account.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: "/feed")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id) 
    {:ok, _user} = Account.delete_user(user)
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: "/")
  end

  def updatemanager(conn, %{"id"=> id}) do
    user = Account.get_user!(id)
    if is_nil(user.manager_id) do
     user1 = Ecto.Changeset.change user, manager_id: conn.assigns.current_user.id
     msg = user.name <> " Added to Team successfully."
   else
    user1 = Ecto.Changeset.change user, manager_id: nil  
    msg = user.name <> " Removed from Team successfully."    
  end
  case Tasks1.Repo.update user1 do
      {:ok, struct}       -> # Updated with success
      users = Account.list_users()
      conn
      |> put_flash(:info, msg)
      |> redirect(to: "/addtoteam", method: :addtoteam)
      {:error, changeset} -> # Something went wrong
      users = Account.list_users()
      redirect(conn,  to: "/addtoteam", method: :addtoteam)
    end
  end

  def addtoteam(conn,_params) do
    users = Account.list_users()
    render(conn, "manage.html", users: users)
  end

  def profile(conn,_params) do
    users = Account.list_users()
    render(conn, "profile.html", users: users)    
  end

  def taskreports(conn,_params) do
    tasks = Tasks1.TaskDetails.list_tasks()
    tasks1 = Enum.filter(tasks,fn(x) -> x.user.manager_id === conn.assigns.current_user.id end)
    render(conn, "taskreports.html", tasks: tasks1)
  end

end
