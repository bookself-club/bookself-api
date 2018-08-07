defmodule BookselfWeb.GraphQL.Libraries.Queries.SearchBooksTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user = insert(:user)

    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn}
  end

  @query """
  query {
    searchBooks(filter: "Title") {
      id
      title
    }
  }
  """
  test "search books using a term", %{conn: conn } do
    options = %{query: @query}

    response = post(conn, "/graphql", options)

    assert %{"data" => %{
      "searchBooks" => [%{"id" => "1", "title" => "Title"}]
    }} = json_response(response, 200)
  end
end
