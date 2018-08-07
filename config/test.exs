use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bookself, BookselfWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :bookself, Bookself.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "bookself_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Client to connect with Google API for books
config :bookself, :google_api, Bookself.GoogleAPI.Sandbox
config :bookself, :google_api_url, "http://localhost:4000/"
