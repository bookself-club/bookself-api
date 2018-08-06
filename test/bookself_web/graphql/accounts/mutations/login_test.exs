defmodule BookselfWeb.GraphQL.Accounts.Mutation.LoginTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  @query """
  mutation ($email: String!, $password: String!) {
    login(email: $email, password: $password) {
      token
      user { name }
    }
  }
  """
  test "creating an user session" do
    user = insert(:user)

    options = %{
      query: @query,
      variables: %{"email" => user.email, "password" => "12345678"}
    }

    response =
      build_conn()
      |> post("/graphql", options)

    assert %{"data" => %{
      "login" => %{"token" => token, "user" => user_data}}
    } = json_response(response, 200)

    assert %{"name" => user.name} == user_data

    assert {:ok, %{email: user.email, name: user.name}} ==
      BookselfWeb.Authentication.verify_token(token)
  end
end
