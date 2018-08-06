defmodule BookselfWeb.GraphQL.Libraries.Queries do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias BookselfWeb.GraphQL.Libraries.Resolvers
  alias BookselfWeb.GraphQL.Middlewares

  object :library_queries do
    @desc "List all libraries of current user"
    field :libraries, list_of(:library) do
      middleware Middlewares.Authorize, :any
      resolve &Resolvers.list_libraries/3
    end
  end
end
