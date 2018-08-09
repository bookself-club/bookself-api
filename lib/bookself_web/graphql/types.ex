defmodule BookselfWeb.GraphQL.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  import_types BookselfWeb.GraphQL.Common.Enum
  import_types BookselfWeb.GraphQL.Common.Types
  import_types BookselfWeb.GraphQL.Common.Scalar

  import_types BookselfWeb.GraphQL.Accounts.Types
  import_types BookselfWeb.GraphQL.Libraries.Types
end
