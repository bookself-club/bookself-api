defmodule BookselfWeb.GraphQL.Common.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  @desc "An error encountered trying to persist input"
  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end
end
