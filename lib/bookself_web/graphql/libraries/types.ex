defmodule BookselfWeb.GraphQL.Libraries.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias BookselfWeb.GraphQL.Libraries.Resolvers

  @desc "Inputs for library"
  input_object :library_input do
    @desc "Name"
    field :name, non_null(:string)
  end

  @desc "Inputs for library item on create"
  input_object :create_library_item_input do
    @desc "Library ID"
    field :library_id, non_null(:id)
    @desc "Book ID"
    field :book_id, non_null(:id)
  end
  @desc "Inputs for library item on create"
  input_object :update_library_item_input do
    @desc "Library ID"
    field :status, :library_item_status
    @desc "Book ID"
    field :rating, :integer
  end

  @desc "Library response"
  object :library_result do
    field :library, :library
    field :errors, list_of(:input_error)
  end

  @desc "Library item response"
  object :library_item_result do
    field :library_item, :library_item
    field :errors, list_of(:input_error)
  end

  @desc "Library"
  object :library do
    @desc "Library ID"
    field :id, :id
    @desc "Libray name"
    field :name, :string
    @desc "Items"
    field :items, list_of(:library_item) do
      resolve &Resolvers.items_for_library/3
    end
  end

  @desc "Library Item"
  object :library_item do
    @desc "Library item ID"
    field :id, :id
    @desc "Libray item rating"
    field :rating, :integer
    @desc "Libray item status"
    field :status, :string
    @desc "The book"
    field :book, :book do
      resolve &Resolvers.book_for_item/3
    end
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
