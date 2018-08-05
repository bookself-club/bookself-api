defmodule BookselfWeb.GraphQL.Accounts.Schemas do
  @moduledoc false
  use Absinthe.Schema.Notation

  @desc "Inputs for registration"
  input_object :registration_input do
    @desc "Name"
    field :name, non_null(:string)
    @desc "E-mail"
    field :email, non_null(:string)
    @desc "Password"
    field :password, non_null(:string)
    @desc "Password confirmation"
    field :password_confirmation, non_null(:string)
  end

  object :session_result do
    field :session, :session
    field :errors, list_of(:input_error)
  end

  @desc "Session information"
  object :session do
    @desc "JWT token used in HEADERS to authenticate"
    field :token, :string
    @desc "Current user"
    field :user, :user
  end

  @desc "User"
  object :user do
    @desc "User e-mail"
    field :email, :string
    @desc "User name"
    field :name, :string
  end
end
