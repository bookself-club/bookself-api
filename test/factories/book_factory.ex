defmodule Bookself.BookFactory do
  @moduledoc """
  Factory to create a new book.

      import Bookself.Factory

      book = insert(:book)
  """

  defmacro __using__(_opts) do
    quote do
      def book_factory do
        %Bookself.Libraries.Book{
          title: "Title",
          external_id: "1000",
          external_service: "google",
          categories: ["Fiction"],
          authors: ["Author"],
          description: "Some book description",
          thumbnail: "URL to image",
          url: "URL to book in store",
          isbn13: "1234567890123",
          isbn10: "123456790",
          pages: 300,
          preview_link: "URL to preview",
          published_date: "2018-01-10",
          publisher: "Publisher"
        }
      end
    end
  end
end
