defmodule BookselfWeb.GraphQL.Accounts.Resolvers do
  @moduledoc false
  alias Bookself.Accounts

  def registration(_, %{input: new_user_input}, _) do
    with {:ok, user} <- Accounts.create_user(new_user_input) do
      token = BookselfWeb.Authentication.sign_user(user)
      {:ok, %{session: %{token: token, user: user}}}
    end
  end

  def login(_, %{email: email, password: password}, _) do
    case Accounts.authenticate(email, password) do
      {:ok, user} ->
        token = BookselfWeb.Authentication.sign_user(user)
        {:ok, %{token: token, user: user}}
      _ ->
        {:error, "incorrect email or password"}
    end
  end

  def profile(_, _, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def profile(_, _, _) do
    {:ok, nil}
  end
end
