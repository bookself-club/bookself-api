defmodule Bookself.Libraries.Library do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "libraries" do
    field :name, :string

    belongs_to :user, Bookself.Accounts.User
    has_many :items, Bookself.Libraries.Item

    timestamps()
  end

  @doc false
  def changeset(library, attrs) do
    library
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
