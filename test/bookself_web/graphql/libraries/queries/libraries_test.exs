defmodule BookselfWeb.GraphQL.Libraries.Queries.LibrariesTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user = insert(:user)
    insert(:library, user: user)

    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn}
  end

  @query """
  query {
    libraries {
      name
    }
  }
  """
  test "list current user's libraries", %{conn: conn } do
    response = post(conn, "/graphql", %{query: @query})

    assert %{"data" => %{
      "libraries" => [%{"name" => "Library"}]
    }} = json_response(response, 200)
  end
end
