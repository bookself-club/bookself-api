defmodule BookselfWeb.Router do
  use BookselfWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BookselfWeb do
    pipe_through :api
  end
end
