defmodule BookselfWeb.GraphQL.Accounts.Queries do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias BookselfWeb.GraphQL.Accounts.Resolvers
  alias BookselfWeb.GraphQL.Middlewares

  object :account_queries do
   @desc "Current user's profile"
   field :profile, :user do
     middleware Middlewares.Authorize, :any
     resolve &Resolvers.profile/3
   end
 end
end
