defmodule BookselfWeb.GraphQL.Mutations do
  @moduledoc false
  use Absinthe.Schema.Notation

  import_types BookselfWeb.GraphQL.Accounts.Mutations
  import_types BookselfWeb.GraphQL.Libraries.Mutations
end
