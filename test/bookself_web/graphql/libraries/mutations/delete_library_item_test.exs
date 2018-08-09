defmodule BookselfWeb.GraphQL.Libraries.Mutations.DeleteLibraryItemTest do
  use BookselfWeb.ConnCase, async: true

  import Bookself.Factory

  setup do
    user    = insert(:user)
    library = insert(:library, user: user)
    book    = insert(:book)
    item    = insert(:library_item, library: library, book: book)

    token = BookselfWeb.Authentication.sign_user(user)

    conn =
      build_conn()
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn, item: item}
  end

  @query """
  mutation ($id: ID!) {
    deleteLibraryItem(id: $id)
  }
  """
  test "delete the library item", %{conn: conn, item: item} do
    options = %{
      query: @query,
      variables: %{
        id: item.id
      }
    }

    response = post(conn, "/graphql", options)

    assert %{
      "data" => %{
        "deleteLibraryItem" => "Book was successfully removed"
      }
    } = json_response(response, 200)
  end
end
