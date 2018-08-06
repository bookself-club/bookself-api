defmodule BookselfWeb.GraphQL.Libraries.Mutations do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias BookselfWeb.GraphQL.Libraries.Resolvers
  alias BookselfWeb.GraphQL.Middlewares

  object :library_mutations do
    @desc "Create a new library"
    field :create_library, :library_result do
      arg :input, non_null(:library_input)

      middleware Middlewares.Authorize, :any
      resolve &Resolvers.create_library/3
    end

    @desc "Update the library"
    field :update_library, :library_result do
      arg :id, non_null(:id)
      arg :input, non_null(:library_input)

      middleware Middlewares.Authorize, :any
      resolve &Resolvers.update_library/3
    end

    @desc "Delete the library"
    field :delete_library, :string do
      arg :id, non_null(:id)

      middleware Middlewares.Authorize, :any
      resolve &Resolvers.delete_library/3
    end
  end
end
