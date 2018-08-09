defmodule BookselfWeb.GraphQL.Common.Enum do
  @moduledoc false
  use Absinthe.Schema.Notation

  enum :library_item_status do
    value :want
    value :have
    value :change
  end
end
