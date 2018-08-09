defmodule BookselfWeb.GraphQL.Libraries.Resolvers do
  @moduledoc false

  @google_api Application.get_env(:bookself, :google_api)

  alias Bookself.Libraries

  @doc """
  Returns all libraries from the current user
  """
  def list_libraries(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Libraries.list_libraries(current_user)}
  end

  @doc """
  Create a new library for the current user
  """
  def create_library(_, %{input: library_input}, %{context: %{current_user: current_user}}) do
    library_input = Map.put(library_input, :user_id, current_user.id)

    with {:ok, library} <- Libraries.create_library(library_input) do
      {:ok, %{library: library}}
    end
  end

  @doc """
  Update the library for the current user
  """
  def update_library(_, %{id: id, input: library_input}, %{context: %{current_user: current_user}}) do
    library = load_library(current_user, id)

    with {:ok, library} <- Libraries.update_library(library, library_input) do
      {:ok, %{library: library}}
    end
  end

  @doc """
  Delete the library for the current user
  """
  def delete_library(_, %{id: id}, %{context: %{current_user: current_user}}) do
    library = load_library(current_user, id)

    with {:ok, _} <- Libraries.delete_library(library) do
      {:ok, "Library was successfully deleted"}
    end
  end

  defp load_library(user, id) do
    Libraries.get_library(user, id)
  end

  @doc """
  Create a new library item
  """
  def create_library_item(_, %{input: library_item_input}, %{context: %{current_user: current_user}}) do
    try do
      with {:ok, item} <- Libraries.create_library_item(current_user, library_item_input) do
        {:ok, %{library_item: item}}
      end
    rescue
      _ -> {:error, "Book already in library"}
    end
  end

  @doc """
  Update the library item
  """
  def update_library_item(_, %{id: id, input: input}, %{context: %{current_user: current_user}}) do
    item = load_library_item(current_user, id)

    with {:ok, item} <- Libraries.update_library_item(item, input) do
      {:ok, %{library_item: item}}
    end
  end

  @doc """
  Delete the library for the current user
  """
  def delete_library_item(_, %{id: id}, %{context: %{current_user: current_user}}) do
    item = load_library_item(current_user, id)

    with {:ok, _} <- Libraries.delete_library_item(item) do
      {:ok, "Book was successfully removed"}
    end
  end

  @doc """
  Returns item of a library
  """
  def items_for_library(library, _, _) do
    {:ok, Libraries.get_items(library)}
  end

  defp load_library_item(user, id) do
    Libraries.get_library_item(user, id)
  end

  @doc """
  Search book on Google API
  """
  def search_books(_, %{filter: filter}, _) do
    with {:ok, books} <- @google_api.search_books(filter) do
      {:ok, books}
    end
  end

  @doc """
  Returs the book of a library item
  """
  def book_for_item(item, _, _) do
    {:ok, Libraries.get_book(item.book_id)}
  end
end
