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

  @desc "Library"
  object :library do
    @desc "Library ID"
    field :id, :id
    @desc "Libray name"
    field :name, :string
  end

  @desc "Book"
  object :book do
    @desc "Book ID"
    field :id, :id
    @desc "Book authors"
    field :authors, list_of(:string)
    @desc "Book categories"
    field :categories, list_of(:string)
    @desc "Book description"
    field :description, :string
    @desc "Book ISBN10"
    field :isbn10, :string
    @desc "Book IBSN13"
    field :isbn13, :string
    @desc "Book pages"
    field :pages, :string
    @desc "Preview link in Google Store"
    field :preview_link, :string
    @desc "Published date of book"
    field :published_date, :string
    @desc "Publisher of book"
    field :publisher, :string
    @desc "Book title"
    field :title, :string
    @desc "Book cover image"
    field :thumbnail, :string
  end
end
