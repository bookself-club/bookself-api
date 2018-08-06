defmodule BookselfWeb.GraphQL.Queries do
  @moduledoc false
  use Absinthe.Schema.Notation

  import_types BookselfWeb.GraphQL.Accounts.Queries
  import_types BookselfWeb.GraphQL.Libraries.Queries
end
