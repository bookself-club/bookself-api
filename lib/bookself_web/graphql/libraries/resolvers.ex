defmodule BookselfWeb.GraphQL.Libraries.Resolvers do
  @moduledoc false
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
end
