defmodule BookselfWeb.Router do
  use BookselfWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    plug BookselfWeb.Context
  end

  scope "/api", BookselfWeb do
    pipe_through :api
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: BookselfWeb.GraphQL.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: BookselfWeb.GraphQL.Schema
  end
end
