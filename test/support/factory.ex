defmodule Bookself.Factory do
  @moduledoc """
  Add support to use factory with ex_machina
  """

  use ExMachina.Ecto, repo: Bookself.Repo

  use Bookself.BookFactory
  use Bookself.LibraryFactory
  use Bookself.LibraryItemFactory
  use Bookself.UserFactory
end
