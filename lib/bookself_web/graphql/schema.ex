defmodule BookselfWeb.GraphQL.Schema do
  @moduledoc false
  use Absinthe.Schema

  alias BookselfWeb.GraphQL.Middlewares

  # Schemas
  import_types BookselfWeb.GraphQL.Accounts.Schemas
  import_types BookselfWeb.GraphQL.Common.Schemas

  # Queries
  import_types BookselfWeb.GraphQL.Accounts.Queries

  # Mutations
  import_types BookselfWeb.GraphQL.Accounts.Mutations

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middlewares.ChangesetErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end

  query do
    import_fields :account_queries
  end

  mutation do
    import_fields :account_mutations
  end
end
