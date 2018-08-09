defmodule Bookself.Libraries do
  @moduledoc false

  import Ecto.Query, warn: false

  alias Bookself.Repo

  alias Bookself.Accounts.User

  alias Bookself.Libraries.Book
  alias Bookself.Libraries.Library
  alias Bookself.Libraries.Item

  @doc """
  Upsert books
  """
  def insert_or_update_book(%Book{} = attrs) do
    case Repo.get_by(Book, external_id: attrs.external_id) do
      %Book{} = book -> book
      _ ->
        {:ok, book } = Repo.insert(attrs)
        book
    end
  end

  @doc """
  Find a book by id
  """
  def get_book(id), do: Bookself.Repo.get(Book, id)

  @doc """
  Returns all libraries from user
  """
  def list_libraries(%User{id: id}) do
    query = from l in Library, where: l.user_id == ^id, order_by: l.name
    Repo.all(query)
  end

  @doc """
  Find library by user id and library id
  """
  def get_library(%User{id: user_id}, id) do
    Repo.get_by(Library, user_id: user_id, id: id)
  end

  @doc """
  Create a new library
  """
  def create_library(attrs \\ %{}) do
    %Library{}
    |> Library.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update the library
  """
  def update_library(%Library{} = library, attrs \\ %{}) do
    library
    |> Library.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Destroy the library
  """
  def delete_library(%Library{} = library) do
    Repo.delete(library)
  end

  @doc """
  Get items of a library
  """
  def get_items(library) do
    query = Ecto.assoc(library, :items)
    Bookself.Repo.all(query)
  end

  @doc """
  Returns the item of library
  """
  def get_library_item(%User{id: user_id}, id) do
    query = from i in Item,
      join: l in Library,
      where: l.user_id == ^user_id and i.id == ^id

    Repo.one(query)
  end

  @doc """
  Create a library item to user
  """
  def create_library_item(%User{} = user, attrs \\ %{}) do
    Repo.get_by!(Library, user_id: user.id, id: attrs.library_id)

    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update the library
  """
  def update_library_item(%Item{} = item, attrs \\ %{}) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Destroy the library item
  """
  def delete_library_item(%Item{} = item) do
    Repo.delete(item)
  end
end
