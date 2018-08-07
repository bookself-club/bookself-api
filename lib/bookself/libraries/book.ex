defmodule Bookself.Libraries.Book do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset


  schema "books" do
    field :authors, {:array, :string}
    field :categories, {:array, :string}
    field :description, :string
    field :external_id, :string
    field :external_service, :string
    field :isbn10, :string
    field :isbn13, :string
    field :pages, :integer
    field :preview_link, :string
    field :published_date, :string
    field :publisher, :string
    field :thumbnail, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @required ~w(title external_id external_service authors description pages
               publised_date publisher)a

  @optional ~w(categories thumbnail url isbn13 isbn10 preview_link)a

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, @optional ++ @required)
    |> validate_required(@required)
  end
end
