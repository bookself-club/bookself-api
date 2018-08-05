# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bookself,
  ecto_repos: [Bookself.Repo]

# Configures the endpoint
config :bookself, BookselfWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bqfR3XOPqmYjgm6TRPOjnQ/UXw7MBC+ifGqZTl20S3GXrlSoNWIuTqfJAN2p56sK",
  render_errors: [view: BookselfWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Bookself.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Comeonin with Bcrypt
config :comeonin, :bcrypt_log_rounds, 14

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
