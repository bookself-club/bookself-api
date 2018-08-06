defmodule BookselfWeb.GraphQL.Schema do
  @moduledoc false
  use Absinthe.Schema

  alias BookselfWeb.GraphQL.Middlewares

  import_types BookselfWeb.GraphQL.Types
  import_types BookselfWeb.GraphQL.Queries
  import_types BookselfWeb.GraphQL.Mutations

  # Middlewares
  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middlewares.ChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  query do
    import_fields :account_queries
    import_fields :library_queries
  end

  mutation do
    import_fields :account_mutations
    import_fields :library_mutations
  end
end
