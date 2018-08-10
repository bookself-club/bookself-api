defmodule Bookself.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bookself,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Bookself.Application, []},
      extra_applications: [:comeonin, :logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # == Phoenix dependences
      {:phoenix, "~> 1.3.2"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      # == App Dependences
      # GraphQL with absinthe
      {:absinthe, "~> 1.4.13"},
      {:absinthe_plug, "~> 1.4.5"},
      {:absinthe_phoenix, "~> 1.4.3"},
      {:absinthe_relay, "~> 1.4.3"},
      # Bcrypt password hashing algorithm
      {:bcrypt_elixir, "~> 1.0"},
      # Ecto type for saving encrypted passwords
      {:comeonin_ecto_password, "~> 2.1"},
      # Static code analysis tool for the Elixir language with a focus on
      # teaching and code consistency
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false},
      # Simplify deployments in Elixir with OTP releases
      {:distillery, "~> 2.0.0-rc.8"},
      # Ecto extension to support enums in models
      {:ecto_enum, "~> 1.0"},
      # Coverage report tool for Elixir with coveralls.io integration
      {:excoveralls, "~> 0.8", only: :test},
      # Produces HTML and EPUB documentation for Elixir projects
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      # Elixir Plug to add CORS
      {:cors_plug, "~> 1.5"},
      # Create test data for Elixir applications
      {:ex_machina, "~> 2.2", only: :test},
      # HTTP client
      {:httpoison, "~> 1.0"},
      # JWT Library
      {:joken, "~> 1.5"},
      # JSON library
      {:poison, "~> 3.1"},
      # Security-focused static analysis for the Phoenix Framework
      {:sobelow, "~> 0.7.1", only: [:dev, :test], runtime: false},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
