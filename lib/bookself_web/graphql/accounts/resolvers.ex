defmodule BookselfWeb.GraphQL.Accounts.Resolvers do
  @moduledoc false
  alias Bookself.Accounts

  @doc """
  Registrate a new user and return the JWT token and the user
  """
  def registration(_, %{input: new_user_input}, _) do
    with {:ok, user} <- Accounts.create_user(new_user_input) do
      token = BookselfWeb.Authentication.sign_user(user)
      {:ok, %{session: %{token: token, user: user}}}
    end
  end

  @doc """
  Login the user with e-mail and plain password and retorn the user and JWT
  token
  """
  def login(_, %{email: email, password: password}, _) do
    case Accounts.authenticate(email, password) do
      {:ok, user} ->
        token = BookselfWeb.Authentication.sign_user(user)
        {:ok, %{token: token, user: user}}
      _ ->
        {:error, "incorrect email or password"}
    end
  end

  @doc """
  Update the current user profile
  """
  def update_profile(_, %{input: profile_input}, %{context: %{current_user: current_user}}) do
    with {:ok, user} <- Accounts.update_user(current_user, profile_input) do
      {:ok, %{user: user}}
    end
  end

  @doc """
  Return the current user profile info
  """
  def profile(_, _, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def profile(_, _, _) do
    {:ok, nil}
  end
end
