defmodule Tasks1Web.Router do
  use Tasks1Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  #Attribution : https://github.com/NatTuck/microblog/blob/part-two/lib/microblog_web/router.ex
  def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Tasks1.Account.get_user!(user_id)     
      assign(conn, :current_user, user)
    else    
      assign(conn, :current_user, nil)  
    end
    
    
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
  end

  scope "/", Tasks1Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/feed", PageController, :feed


    get "/addtoteam", UserController, :addtoteam
    get "/profile", UserController, :profile
    get "/taskreports", UserController, :taskreports
    get "/addtoteam/:id", UserController, :updatemanager
    get "/users/newmanager",UserController, :newmanager

    get "/blocks/:id/edit", BlockController, :edit
    put "/blocks/:id", BlockController, :updatetimeblock
    get "/blocks/:id/newblock", BlockController, :newblock
    post "/blocks/:id", BlockController, :add_timeblock

    resources "/users", UserController
    resources "/tasks", TaskController
    get "/tasktimeblocks", TaskController, :tracktimeblocks

    #creating Login/logout from scratch
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", Tasks1Web do
     pipe_through :api
     resources "/blocks", BlockController, except: [:new, :edit]
  end
end
