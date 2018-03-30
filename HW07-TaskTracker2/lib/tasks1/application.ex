defmodule Tasks1.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Tasks1.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Tasks1Web.Endpoint, []),
      # Start your own worker by calling: Tasks1.Worker.start_link(arg1, arg2, arg3)
      # worker(Tasks1.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tasks1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Tasks1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
