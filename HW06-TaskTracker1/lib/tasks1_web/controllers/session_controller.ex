defmodule Tasks1Web.SessionController do
  use Tasks1Web, :controller
  #Using Session Mechanism of phoenix
  #Attribution: https://github.com/NatTuck/microblog/blob/part-two/lib/microblog_web/controllers/session_controller.ex
  def create(conn,%{"email"=>email}) do
    user = Tasks1.Account.get_user_by_email(email)
    if user do
    	conn
    	|> put_session(:user_id, user.id)
    	|> put_flash(:info, "Welcome back, #{user.name}")
    	|> redirect(to: "/feed")
    else
    	conn
    	|> put_flash(:error, "Can't create session")
    	|> redirect(to: page_path(conn, :index))      
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
