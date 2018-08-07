defmodule Bookself.GoogleAPI.HTTPClient do
  @moduledoc """
  Find book from Google API
  """

  @behaviour Bookself.GoogleAPI

  @google_api_url Application.get_env(:bookself, :google_api_url)

  alias Bookself.GoogleAPI.Parser

  def search_books(filter) when is_binary(filter) do
    filter
    |> google_api_url
    |> HTTPoison.get
    |> handle_response
  end

  def search_books(_) do
    {:ok, []}
  end

  def google_api_url(filter) do
    "#{@google_api_url}?#{URI.encode_query(%{q: filter})}"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    books =
      body
      |> Poison.Parser.parse!
      |> parse_books

    {:ok, books}
  end

  def handle_response({_, %{status_code: _status, body: body}}) do
    {:error, Poison.Parser.parse!(body)}
  end

  def parse_books(%{"items" => books}) do
    for book <- books do
      Parser.parse(book)
    end
  end
end
