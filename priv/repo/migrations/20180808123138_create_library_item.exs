defmodule Bookself.Repo.Migrations.CreateLibraryItem do
  use Ecto.Migration

  def change do
    create table(:library_item) do
      add :book_id,    references(:books, on_delete: :nothing)
      add :library_id, references(:libraries, on_delete: :delete_all)

      add :rating, :integer, default: 0, null: false
      add :status, :integer, default: 0

      timestamps()
    end

    create index(:library_item, [:library_id])
    create index(:library_item, [:book_id])

    create unique_index(:library_item, [:library_id, :book_id])
  end
end
