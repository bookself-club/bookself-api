defmodule Bookself.LibraryItemFactory do
  @moduledoc """
  Factory to create a new library item.

      import Bookself.Factory

      library_item = insert(:library_item)
  """

  defmacro __using__(_opts) do
    quote do
      def library_item_factory do
        %Bookself.Libraries.Item{
          book: build(:book),
          library: build(:library),
          status: :have,
          rating: 4,
        }
      end
    end
  end
end
