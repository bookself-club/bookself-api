defmodule Bookself.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :description, :text
      add :isbn13, :string
      add :isbn10, :string
      add :pages, :integer

      add :published_date, :string
      add :publisher, :string

      add :external_id, :string
      add :external_service, :string

      add :authors, {:array, :string}
      add :categories, {:array, :string}

      add :thumbnail, :string
      add :url, :string
      add :preview_link, :string

      timestamps()
    end

    create index(:books, [:external_id])
    create index(:books, [:isbn13])
  end
end
