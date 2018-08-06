defmodule BookselfWeb.GraphQL.Libraries.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  @desc "Inputs for library"
  input_object :library_input do
    @desc "Name"
    field :name, non_null(:string)
  end

  @desc "Library response"
  object :library_result do
    field :library, :library
    field :errors, list_of(:input_error)
  end

  @desc "Library information"
  object :library do
    @desc "Library ID"
    field :id, :id
    @desc "Libray name"
    field :name, :string
  end
end
