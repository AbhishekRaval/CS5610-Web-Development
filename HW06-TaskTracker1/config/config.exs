# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tasks1,
  ecto_repos: [Tasks1.Repo]

# Configures the endpoint
config :tasks1, Tasks1Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mgv7auwogeeiWZc4wLe1nNQO4HCnPPrCIwxJH+SXAWs1b1FfbrQiYcwq6oP9x5vb",
  render_errors: [view: Tasks1Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tasks1.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
