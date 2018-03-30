use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.

# You can generate a new secret by running:
#
#     mix phx.gen.secret
config :othello, Othello.Endpoint,
  secret_key_base: "X6JbOUJBojnmiT+K1LgmbaE9Gvol/y4iPRq591+/v3EMdmkPaXRSawHlyz/ozbFQ"

# Configure your database
config :othello, Othello.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "othello",
  password: "ihix4ahChedu",
  database: "othello_prod",
  size: 20 # The amount of database connections in the pool
