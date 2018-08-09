defmodule BookselfWeb.GraphQL.Common.Scalar do
  @moduledoc false
  use Absinthe.Schema.Notation

  # Example of date scalar
  #
  #     @desc """
  #     The `Date` scalar type represents a ISO date.
  #     (e.g. "2017-06-19").
  #     """
  #     scalar :date, description: "ISO date" do
  #       parse fn input ->
  #         case Date.to_iso8601(input.value) do
  #           {:error, _reason} -> :error
  #           result -> result
  #         end
  #       end
  #
  #       serialize &Date.from_iso8601(&1)
  #     end
end
