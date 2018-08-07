defmodule Bookself.GoogleAPI.Parser do
  @moduledoc """
  Make parse to Book struct form Google API
  """

  alias Bookself.Libraries

  def parse(book) do
    book
    |> build_struct
  end

  defp build_struct(%{"volumeInfo" => info} = book) do
    %Libraries.Book{
      title: info["title"],
      external_id: book["id"],
      external_service: "google",
      categories: info["categories"],
      authors: info["authors"],
      description: info["description"],
      thumbnail: info["imageLinks"]["thumbnail"],
      url: info["infoLink"],
      isbn13: extract_ibsn13(info["industryIdentifiers"]),
      isbn10: extract_ibsn10(info["industryIdentifiers"]),
      pages: info["pageCount"],
      preview_link: info["previewLink"],
      published_date: info["publishedDate"],
      publisher: info["publisher"],
    }
    |> Libraries.insert_or_update_book
  end

  defp extract_ibsn13(codes) do
    extract_ibsn(codes, "ISBN_13")
  end

  defp extract_ibsn10(codes) do
    extract_ibsn(codes, "ISBN_10")
  end

  defp extract_ibsn(codes, type) do
    ibsn = Enum.find(codes, %{}, fn code -> type == code["type"] end)
    ibsn["identifier"]
  end
end
