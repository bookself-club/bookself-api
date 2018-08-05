defmodule Bookself.Accounts do
  @moduledoc false
  alias Bookself.Repo
  alias Comeonin.Ecto.Password

  alias Bookself.Accounts.User

  @doc"""
    Authenticate the user with email and plain password
  """
  def authenticate(email, password) do
    user = Repo.get_by(User, email: email)

    with %{password: digest} <- user,
         true <- Password.valid?(password, digest) do
      {:ok, user}
    else
      _ -> :error
    end
  end

  def lookup(email) do
    Repo.get_by(User, email: email)
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
