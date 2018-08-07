defmodule Bookself.GoogleAPI.Sandbox do
  @moduledoc """
  A mock module to use in tests
  """

  @behaviour Bookself.GoogleAPI

  def search_books(_) do
    books =
      [
        %Bookself.Libraries.Book{
          id: 1,
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
          published_date: "2017-01-10",
          publisher: "Publisher"
        }
      ]

    {:ok, books}
  end
end
