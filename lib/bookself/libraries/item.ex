defmodule Bookself.Libraries.Item do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset


  schema "library_item" do
    field :rating, :integer, read_after_writes: true
    field :status, LibraryItemStatusEnum, read_after_writes: true

    belongs_to :book, Bookself.Libraries.Book
    belongs_to :library, Bookself.Libraries.Library

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:book_id, :library_id, :rating, :status])
    |> validate_required([:book_id, :library_id])
  end
end
