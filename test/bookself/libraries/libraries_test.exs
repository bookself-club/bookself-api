defmodule Booksel.LibrariesTest do
  use BookselfWeb.ConnCase, async: true

  alias Bookself.Libraries

  import Bookself.Factory

  describe "#insert_or_update_book" do
    setup do
      book = insert(:book)

      {:ok, book: book}
    end

    test "returns the existing book when external id already in book table", %{book: book} do
      new_book = %Libraries.Book{external_id: book.external_id}

      result = Libraries.insert_or_update_book(new_book)

      assert result == book
    end

    test "create a new book", %{book: book} do
      attrs    = params_for(:book, external_id: "EXID#10000")
      new_book = struct(%Libraries.Book{}, attrs)

      result = Libraries.insert_or_update_book(new_book)

      assert result.id != book.id
      assert result.external_id == "EXID#10000"
    end
  end

  describe "#get_items" do
    test "returns all items of a library" do
      library = insert(:library)
      item    = insert(:library_item, library: library)

      returned =
        library
        |> Libraries.get_items
        |> Enum.map(&(&1.id))

      assert  returned == [item.id]
    end
  end
end
