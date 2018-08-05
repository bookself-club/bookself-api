defmodule BookselfWeb.GraphQL.Accounts.Mutations do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias BookselfWeb.GraphQL.Accounts.Resolvers

  object :account_mutations do
    @desc "Login with user and password"
    field :login, :session do
      @desc "E-mail"
      arg :email, non_null(:string)
      @desc "Password"
      arg :password, non_null(:string)

      resolve &Resolvers.login/3
    end

    @desc "Create a new account"
    field :registration, :session_result do
      arg :input, non_null(:registration_input)

      resolve &Resolvers.registration/3
    end
  end
end
