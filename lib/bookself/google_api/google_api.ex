defmodule Bookself.GoogleAPI do
  @moduledoc false

  @doc "Search books on Google API"
  @callback search_books(filter :: String.t) :: {:ok, [%Bookself.Libraries.Book{}]} | {:error, String.t}
end
