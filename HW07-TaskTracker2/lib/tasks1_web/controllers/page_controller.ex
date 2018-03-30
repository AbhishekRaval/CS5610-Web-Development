defmodule Tasks1Web.PageController do
  use Tasks1Web, :controller
   alias Tasks1.TaskDetails

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
  	tasks = TaskDetails.list_tasks()
    render conn, "feed.html", tasks: tasks
  end
end
