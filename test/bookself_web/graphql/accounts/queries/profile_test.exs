defmodule BookselfWeb.GraphQL.Accounts.Queries.ProfileTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user = insert(:user)
    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn, user: user}
  end

  @query """
  query {
    profile {
      name
      email
    }
  }
  """
  test "creating an user session", %{conn: conn, user: user} do
    response = post(conn, "/graphql", %{query: @query})

    assert %{"data" => %{
      "profile" => %{"name" => name, "email" => email}
    }} = json_response(response, 200)

    assert %{email: ^email, name: ^name} = user
  end
end
