defmodule BookselfWeb.GraphQL.Accounts.Mutations do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias BookselfWeb.GraphQL.Accounts.Resolvers
  alias BookselfWeb.GraphQL.Middlewares

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

    @desc "Update the current user profile"
    field :update_profile, :profile_result do
      arg :input, non_null(:profile_input)

      middleware Middlewares.Authorize, :any
      resolve &Resolvers.update_profile/3
    end
  end
end
