use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :bookself, BookselfWeb.Endpoint,
  load_from_system_env: true,
  server: true, # Without this line, your app will not start the web server!
  secret_key_base: System.get_env("SECRET_KEY")

# Configure your database
config :bookself, Bookself.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  database: "",
  ssl: true,
  pool_size: 1
