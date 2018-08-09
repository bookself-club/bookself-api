defmodule Bookself.GoogleAPI.ParserTest do
  use BookselfWeb.ConnCase, async: true

  alias Bookself.GoogleAPI.Parser
  alias Bookself.Libraries.Book

  setup do
    {:ok, google_api_response} = read_json()
    {:ok, json: google_api_response}
  end

  def read_json do
    files_dir = "#{File.cwd!}/test/files"

    with {:ok, body} <- File.read("#{files_dir}/google_api_response.json"),
         {:ok, json} <- Poison.decode(body) do
      {:ok, json}
    end
  end

  test "parse the json to %Book{}", %{json: json} do
    %{"items" => books} = json

    book = List.first(books)
    result = Parser.parse(book)

    assert %Book{
        authors: ["Author"],
        categories: ["Fiction"],
        description: "Great Book",
        external_id: "EXID-100000",
        external_service: "google",
        id: _,
        inserted_at: _,
        isbn10: "1234567890",
        isbn13: "1234567890123",
        pages: 304,
        preview_link: "http://books.google.com.br/books?id=EXID-100000",
        published_date: "2018-01-01",
        publisher: "Publisher",
        thumbnail: "http://books.google.com/books/thumbnail?id=EXID-100000",
        title: "Book",
        updated_at: _,
        url: "https://play.google.com/store/books/details?id=EXID-100000"
      } = result
  end
end
