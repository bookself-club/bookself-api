defmodule Bookself.Factory do
  @moduledoc """
  Add support to use factory with ex_machina
  """

  use ExMachina.Ecto, repo: Bookself.Repo
  use Bookself.UserFactory
end
